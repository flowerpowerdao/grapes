import Time "mo:base/Time";

import Cap "mo:cap/Cap";

import ExtCore "../toniq-labs/ext/Core";
import Tokens "../Tokens";
import Disburser "../Disburser";
import Types "../types";

module {
  public type StableChunk = ?{
    // v2
    #v2: {
      saleTransactionCount : Nat;
      saleTransactionChunk : [SaleTransaction];
      salesSettlements : [(AccountIdentifier, Sale)];
      failedSales : [(AccountIdentifier, SubAccount)];
      tokensForSale : [TokenIndex];
      whitelistSpots : [(WhitelistSpotId, RemainingSpots)];
      soldIcp : Nat64;
      sold : Nat;
      totalToSell : Nat;
      nextSubAccount : Nat;
    };
    #v2_chunk: {
      saleTransactionChunk : [SaleTransaction];
    };
    // v3
    #v3: {
      saleTransactionCount : Nat;
      saleTransactionChunk : [SaleTransactionV3];
      salesSettlements : [(AccountIdentifier, SaleV3)];
      failedSales : [SaleV3];
      tokensForSale : [TokenIndex];
      whitelistSpots : [(WhitelistSpotId, RemainingSpots)];
      saleCountByLedger : [(Principal, Nat)];
      saleVolumeByLedger : [(Principal, Nat)];
      totalToSell : Nat;
      nextSubAccount : Nat;
    };
    #v3_chunk: {
      saleTransactionChunk : [SaleTransactionV3];
    };
  };

  public type Dependencies = {
    _Cap : Cap.Cap;
    _Tokens : Tokens.Factory;
    _Disburser : Disburser.Factory;
  };

  public type Whitelist = Types.Whitelist;
  public type WhitelistSlot = Types.WhitelistSlot;
  public type WhitelistSpotId = Text; // <whitelist_name>:<address>
  public type RemainingSpots = Nat;
  public type AccountIdentifier = ExtCore.AccountIdentifier;
  public type Address = Text;
  public type TokenIdentifier = ExtCore.TokenIdentifier;
  public type SubAccount = ExtCore.SubAccount;
  public type CommonError = ExtCore.CommonError;
  public type TokenIndex = ExtCore.TokenIndex;
  public type Time = Time.Time;

  public type Tokens = {
    e8s : Nat64;
  };

  public type SaleV1 = {
    tokens : [TokenIndex];
    price : Nat64;
    subaccount : SubAccount;
    buyer : AccountIdentifier;
    expires : Time;
    slot : ?WhitelistSlot;
  };

  public type Sale = {
    tokens : [TokenIndex];
    price : Nat64;
    subaccount : SubAccount;
    buyer : AccountIdentifier;
    expires : Time;
    whitelistName: ?Text;
  };

  public type SaleTransaction = {
    tokens : [TokenIndex];
    seller : Principal;
    price : Nat64;
    buyer : AccountIdentifier;
    time : Time;
  };

  public type SaleSettings = {
    price : Nat64;
    salePrice : Nat64;
    sold : Nat;
    remaining : Nat;
    startTime : Time;
    endTime : Time;
    whitelistTime : Time;
    whitelist : Bool;
    totalToSell : Nat;
    openEdition : Bool;
  };

  // V3
  public type SaleV3 = {
    tokens : [TokenIndex];
    price : Nat64;
    ledger : Principal;
    subaccount : SubAccount;
    buyer : Address;
    expires : Time;
    whitelistName: ?Text;
  };

  public type SaleTransactionV3 = {
    tokens : [TokenIndex];
    seller : Principal;
    price : Nat64;
    ledger : Principal;
    buyer : Address;
    time : Time;
  };

  public type SaleSettingsV3 = {
    prices : [Types.PriceInfo];
    salePrices : [Types.PriceInfo];
    price : Nat64; // legacy ICP price
    salePrice : Nat64; // legacy ICP price
    sold : Nat;
    remaining : Nat;
    remainingByLedger : [(Principal, Nat)];
    startTime : Time;
    endTime : Time;
    whitelistTime : Time;
    whitelist : Bool;
    totalToSell : Nat;
    openEdition : Bool;
  };
};
