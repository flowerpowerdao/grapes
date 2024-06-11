import { Actor } from '@dfinity/agent';
import { AccountIdentifier } from '@dfinity/ledger-icp';
import { Principal } from '@dfinity/principal';
import { Secp256k1KeyIdentity } from '@dfinity/identity-secp256k1';
import { decodeIcrcAccount, encodeIcrcAccount } from '@dfinity/ledger-icrc';

import { generateIdentity } from './generate-identity';
import { createAgent } from './create-agent';

// @ts-ignore
import { idlFactory as idlFactoryMain } from '../../declarations/main/staging.did.js';
import { _SERVICE as _SERVICE_MAIN } from '../../declarations/main/staging.did';

// @ts-ignore
import { idlFactory as idlFactoryIcp } from '../../declarations/ledger/ledger.did.js';
import { _SERVICE as _SERVICE_ICP } from '../../declarations/ledger/ledger.did';

import canisterIds from '../../.dfx/local/canister_ids.json';


export class User {
  mainActor: _SERVICE_MAIN;
  icpActor: _SERVICE_ICP;
  identity: Secp256k1KeyIdentity;
  principal: Principal;
  account: number[];
  accountId: string;
  address: string;

  constructor(seed?: string) {
    this.identity = seed === '' ? undefined : generateIdentity(seed);

    if (this.identity) {
      this.principal = this.identity.getPrincipal();
      this.account = AccountIdentifier.fromPrincipal({principal: this.principal}).toNumbers();
      this.accountId = AccountIdentifier.fromPrincipal({principal: this.principal}).toHex();
      this.address = encodeIcrcAccount({owner: this.principal});
    }

    this.mainActor = Actor.createActor(idlFactoryMain, {
      agent: createAgent(this.identity),
      canisterId: canisterIds.test.local,
    });

    this.icpActor = Actor.createActor(idlFactoryIcp, {
      agent: createAgent(this.identity),
      canisterId: canisterIds.ledger.local,
    });
  }

  async mintICP(amount: bigint) {
    let minter = new User('minter');

    await minter.icpActor.transfer({
      to: this.account,
      amount: { e8s: amount },
      created_at_time: [],
      memo: 0n,
      fee: { e8s: 0n },
      from_subaccount: [],
    });
  }

  async sendICP(to: string | number[] | Uint8Array, amount: bigint) {
    if (typeof to === 'string' && to.length !== 64) {
      let res = await this.icpActor.icrc1_transfer({
        from_subaccount: [],
        to: {
          owner: decodeIcrcAccount(to).owner,
          subaccount: [decodeIcrcAccount(to).subaccount],
        },
        amount: amount,
        memo: [],
        fee: [],
        created_at_time: [BigInt(Date.now()) * 1_000_000n],
      });
      if ('Err' in res) {
        throw res.Err;
      }
      return;
    }

    let toArr = [];
    if (typeof to === 'string') {
      if (to.length === 64) {
        toArr = AccountIdentifier.fromHex(to).toNumbers();
      }
    }
    else {
      toArr = Array.from(to);
    }

    let res = await this.icpActor.transfer({
      from_subaccount: [],
      to: Array.from<number>(toArr),
      amount: { e8s: amount },
      fee: { e8s: 10_000n },
      memo: 0n,
      created_at_time: [{ timestamp_nanos: BigInt(Date.now()) * 1_000_000n }],
    });
    if ('Err' in res) {
      throw res.Err;
    }
  }
}