import ExtCore "../toniq-labs/ext/Core";

module {
  public type Address = Text;
  public type AccountIdentifier = ExtCore.AccountIdentifier;
  public type SubAccount = ExtCore.SubAccount;
  public type TokenIndex = ExtCore.TokenIndex;

  public type Disbursement = {
    to : AccountIdentifier;
    fromSubaccount : SubAccount;
    amount : Nat64;
    tokenIndex : TokenIndex;
  };

  public type DisbursementV2 = {
    ledger : Principal;
    to : Address;
    fromSubaccount : SubAccount;
    amount : Nat64;
    tokenIndex : TokenIndex;
  };

  public type StableChunk = ?{
    #v1: {
      disbursements : [Disbursement];
    };
    #v2: {
      disbursements : [DisbursementV2];
    };
  };
};
