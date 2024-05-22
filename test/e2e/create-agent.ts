import { HttpAgent } from '@dfinity/agent';
import { Secp256k1KeyIdentity } from '@dfinity/identity-secp256k1';

let rootKey: ArrayBuffer = null;
new HttpAgent({ host: 'http://127.0.0.1:4943' }).fetchRootKey().then((rk) => {
  rootKey = rk;
});

setInterval(() => {
  new HttpAgent({host: 'http://127.0.0.1:4943'}).fetchRootKey().then((rk) => {
    rootKey = rk;
  });
}, 1000 * 60); // 1 minute

export let createAgent = (identity?: Secp256k1KeyIdentity) => {
	let agent = new HttpAgent({
		host: 'http://127.0.0.1:4943',
		identity: identity,
	});

  // use cached root key
  if (rootKey) {
    agent.rootKey = rootKey;
  }
  else {
    agent.fetchRootKey().catch((err) => {
      console.warn(
        'Unable to fetch root key. Check to ensure that your local replica is running'
      );
      console.error(err);
    });
  }

	return agent;
}