import { describe, test, expect } from 'vitest';
import { User } from '../user';
import { buyFromSale, checkTokenCount } from '../utils';
import { whitelistTier0, whitelistTier1 } from '../well-known-users';
import env from './env';
import {Principal} from '@dfinity/principal';

describe('public sale', () => {
  test('try to list nft before marketplace opens', async () => {
    let user = new User;
    let res = await user.mainActor.list({
      price: [BigInt(1000)],
      token: new User().accountId,
      from_subaccount: [],
      frontendIdentifier: [],
    });
    expect(res['err'].Other).toContain('can not list yet');
  });

  test('try to buy from sale with insufficient funds', async () => {
    let user = new User;
    await user.mintICP(1000_000_000n);

    let settings = await user.mainActor.salesSettings(user.address);
    let res = await user.mainActor.reserve(user.address, Principal.fromText('ryjl3-tyaaa-aaaaa-aaaba-cai'));

    expect(res).toHaveProperty('ok');

    if ('ok' in res) {
      let paymentAddress = res.ok[0];
      let paymentAmount = res.ok[1];
      expect(paymentAddress.length).toBeGreaterThanOrEqual(38);
      expect(paymentAmount).toBe(settings.price);

      await user.sendICP(paymentAddress, paymentAmount - 1n);
      let retrieveRes = await user.mainActor.retrieve(paymentAddress, Principal.fromText('ryjl3-tyaaa-aaaaa-aaaba-cai'));
      expect(retrieveRes).toHaveProperty('err');
      expect(retrieveRes['err']).toMatch(/Insufficient funds/i);
    }

    let tokensRes = await user.mainActor.tokens(user.accountId);
    expect(tokensRes).toHaveProperty('err');
    expect(tokensRes['err']['Other']).toBe('No tokens');
  });

  test('buy sequentially 2 nft from sale', async () => {
    let user = new User;
    await user.mintICP(100_000_000_000n);
    let settings = await user.mainActor.salesSettings(user.address);

    await buyFromSale(user);
    await buyFromSale(user);

    await checkTokenCount(user, 2);
  });

  test('buy in parallel 4 nft from sale', async () => {
    let user = new User;
    await user.mintICP(100_000_000_000n);
    let settings = await user.mainActor.salesSettings(user.address);

    await Promise.all([
      buyFromSale(user),
      buyFromSale(user),
      buyFromSale(user),
      buyFromSale(user),
    ]);

    await checkTokenCount(user, 4);
  });
});