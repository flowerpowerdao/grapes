import {writeFileSync} from 'fs';
import {createActor} from './declarations/main';

let options = {
  agentOptions: {
    host: 'https://icp-api.io',
  }
};

let actor = createActor('skjpp-haaaa-aaaae-qac7q-cai', options);

(async () => {
  let punkHolders = (await actor.getRegistry()).map((x) => x[1]);
  console.log('punk holders', punkHolders.length);

  writeFileSync('holders-punk.txt', '"' + punkHolders.join('";\n"') + '";');
})();