import Blob "mo:base/Blob";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import TrieMap "mo:base/TrieMap";
import Nat64 "mo:base/Nat64";
import Debug "mo:base/Debug";

import Encoding "mo:encoding/Binary";
import AviateAccountIdentifier "mo:accountid/AccountIdentifier";
import Account "mo:account";
import LedgerTypes "mo:ledger-types";
import ICRC1 "mo:icrc1-types";

import ExtCore "../toniq-labs/ext/Core";
import Types "types";
import RootTypes "../types";
import Utils "../utils";

module {
  public class Factory(config : RootTypes.Config) {

    /*********
    * STATE *
    *********/

    var _disbursements = List.nil<Types.DisbursementV2>();
    var curNonce : Nat64 = 0;

    public func toStableChunk(_chunkSize : Nat, chunkIndex : Nat) : Types.StableChunk {
      if (chunkIndex != 0) {
        return null;
      };
      ?#v1({
        disbursements = List.toArray(_disbursements);
      });
    };

    public func loadStableChunk(chunk : Types.StableChunk) {
      switch (chunk) {
        case (?#v1(data)) {
          _disbursements := List.fromArray(Array.map<Types.Disbursement, Types.DisbursementV2>(data.disbursements, func(disbursement_v1) {
            {
              disbursement_v1 with
              ledger = Principal.fromText("ryjl3-tyaaa-aaaaa-aaaba-cai");
            }
          }));
        };
        case (?#v2(data)) {
          _disbursements := List.fromArray(data.disbursements);
        };
        case (null) {};
      };
    };

    //*** ** ** ** ** ** ** ** ** * * PUBLIC INTERFACE * ** ** ** ** ** ** ** ** ** ** /

    public func addDisbursement(disbursement : Types.DisbursementV2) : () {
      _disbursements := List.push(disbursement, _disbursements);
    };

    public func getDisbursements() : [Types.DisbursementV2] {
      List.toArray(_disbursements);
    };

    public func cronDisbursements() : async* () {
      label payloop while (true) {
        let (last, newDisbursements) = List.pop(_disbursements);
        switch (last) {
          case (?disbursement) {
            _disbursements := newDisbursements;

            try {
              curNonce := (curNonce + 1) % 1000;
              let ledgerFee = await* _getLedgerFee(disbursement.ledger);

              // ICP ledger
              if (Principal.toText(disbursement.ledger) == "ryjl3-tyaaa-aaaaa-aaaba-cai") {
                let ledger = actor(Principal.toText(disbursement.ledger)) : LedgerTypes.Service;

                let _res = await ledger.transfer({
                  to = switch (AviateAccountIdentifier.fromText(Utils.toAccountId(disbursement.to))) {
                    case (#ok(accountId)) {
                      AviateAccountIdentifier.addHash(accountId);
                    };
                    case (#err(_)) {
                      // this should never happen because account ids are always created from within the
                      // canister which should guarantee that they are valid and we are able to decode them
                      // to [Nat8]
                      continue payloop;
                    };
                  };
                  from_subaccount = ?disbursement.fromSubaccount;
                  amount = { e8s = disbursement.amount };
                  fee = { e8s = ledgerFee };
                  created_at_time = null;
                  memo = curNonce + Encoding.BigEndian.toNat64(Blob.toArray(Principal.toBlob(Principal.fromText(ExtCore.TokenIdentifier.fromPrincipal(config.canister, disbursement.tokenIndex)))));
                });
              }
              // ICRC-1 ledger
              else {
                let account = switch (Account.fromText(disbursement.to)) {
                  case (#ok(account)) {
                    account;
                  };
                  case (#err(err)) {
                    Debug.print("Disburser: error decoding account: " # debug_show(err));
                    _disbursements := List.push(disbursement, _disbursements);
                    break payloop;
                  };
                };

                let ledger = actor(Principal.toText(disbursement.ledger)) : ICRC1.Service;
                let res = await ledger.icrc1_transfer({
                  to = account;
                  from_subaccount = ?Blob.fromArray(disbursement.fromSubaccount);
                  amount = Nat64.toNat(disbursement.amount);
                  fee = ?Nat64.toNat(ledgerFee);
                  created_at_time = null;
                  memo = ?Blob.fromArray(Encoding.BigEndian.fromNat64(curNonce + Encoding.BigEndian.toNat64(Blob.toArray(Principal.toBlob(Principal.fromText(ExtCore.TokenIdentifier.fromPrincipal(config.canister, disbursement.tokenIndex)))))));
                });

                switch (res) {
                  case (#Ok(bh)) {};
                  case (#Err(err)) {
                    Debug.print("Disburser: error transferring funds: " # debug_show(err));
                    _disbursements := List.push(disbursement, _disbursements);
                    break payloop;
                  };
                };
              }
            } catch (e) {
              _disbursements := List.push(disbursement, _disbursements);
              break payloop;
            };
          };
          case (null) {
            break payloop;
          };
        };
      };
    };

    public func pendingCronJobs() : Nat {
      List.size(_disbursements);
    };

    let _feeByLedger = TrieMap.TrieMap<Principal, Nat64>(Principal.equal, Principal.hash);

    func _getLedgerFee(ledger : Principal) : async* Nat64 {
      switch (_feeByLedger.get(ledger)) {
        case (?fee) {
          fee;
        };
        case (null) {
          let ledgerActor = actor(Principal.toText(ledger)) : ICRC1.Service;
          let fee = Nat64.fromNat(await ledgerActor.icrc1_fee());
          _feeByLedger.put(ledger, fee);
          fee;
        };
      };
    };
  };
};
