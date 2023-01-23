import Time "mo:base/Time";
import ExtCore "../toniq-labs/ext/Core";

module {
  public let collectionName = "Pineapple Punks";
  public let placeholderContentLength = "1053832";
  public let teamAddress : ExtCore.AccountIdentifier = "c6650430117d586f5286a570e61f1fc987a4d2c4f75dad4d9ebfd0ad27e62485";
  public let ecscrowDelay : Time.Time = 7777; // 120 seconds
  public let collectionSize : Nat32 = 7777;

  public let salePrice : Nat64 = 700000000;
  public let salesFees : [(ExtCore.AccountIdentifier, Nat64)] = [
    (teamAddress, 7500), // Royalty Fee
    ("c7e461041c0c5800a56b64bb7cefc247abc0bbbb99bd46ff71c64e92d9f5c2f9", 1000), // Entrepot Fee
  ];

  public let publicSaleStart : Time.Time = 1674475269009000000; // Start of first purchase (WL or other)
  public let whitelistTime : Time.Time = 1674475269009000000; // Period for WL only discount. Set to publicSaleStart for no exclusive period
  public let marketDelay : Time.Time = 172800000000000; // How long to delay market opening (2 days after whitelist sale started or when sold out)

  // true - assets will be revealed after manually calling 'shuffleAssets'
  // false - assets will be revealed immediately and assets shuffling will be disabled
  public let delayedReveal = true;

  public let whitelistOneTimeOnly : Bool = true; // Whitelist addresses are removed after purchase
  public let whitelistDiscountLimited : Bool = true; // If the whitelist discount is limited to the whitelist period only. If no whitelist period this is ignored

  // dutch auction
  public type DutchAuctionFor = {
    #everyone; // dutch auction for everyone
    #whitelist; // dutch auction for whitelist(tier price is ignored), then salePrice for public sale
    #publicSale; // tier price for whitelist, then dutch auction for public sale
  };
  public let dutchAuctionEnabled = false;
  public let dutchAuctionFor : DutchAuctionFor = #everyone;
  public let dutchAuctionStartPrice : Nat64 = 21500000000; // start with 350 icp for dutch auction
  public let dutchAuctionIntervalPriceDrop : Nat64 = 500000000; // drop 5 icp every interval
  public let dutchAuctionReservePrice : Nat64 = 500000000; // reserve price is 5 icp
  public let dutchAuctionInterval : Time.Time = 60000000000; // 1 minute

  // Airdrop (only addresses, no token index anymore)
  public let airdropEnabled = false;
  public let airdrop : [ExtCore.AccountIdentifier] = ["e66c26a7e1258984b84dfc92bbfca3084d4252abb0091ca6c1196df2acb18f9d","ae3dbb489190f52c7a9830bbd89e00da4eef57b1d6ca04ede55be4e6fcb61bf9","943fd89889433e9095cdfee0998e51b76c3e89ec96cb1b19b09c51dd60ef61d2","a0b0636cb7e5962c3f8b579d4eaea4fa5cf5bd2b7bca012f7edb4c8e22704a15","aaa8563d505d86d00721da1fc5e6ec6005306fb815aa480d12d82c066279bfd9","a8811f0497f397fc669783447e53a3ee62f58089b28ddbfe8cf4e91a5e37073e","1edf167a947719829359da03128db5b6d18b1c6e0e342df97a21110740fcd4e2","5c064042aa679a9faf58af1b9c4e696110ddfa0502dcafae6c88c333654f1e5c","1f2fa4e9a5e1ad1ded167e898b13693bfaa5f7e7021da33a6ed9f3f71d6c6efd","8ecad355c3bafd563621d50c54d7718f87c17f27b1da7d2b954ef0c8824ae552","943bc8a34c70aa051765133096c936d5e0087adbe7015a9052c2bc95cb9894fb","923081287fff9e953965200c916a24c94a9e7aaf6197511e39b272f25161925d","07a73e6925c30170497fa8c1d8f0a83920c1fc65b96ba73ad179925a3ed01821","d4756e1d8ef5a5be63e00502168d30d690d9af00bfdf40c8808e0cae5dd7d156","fcfa9dec3eec14f189834e767d0caabb01288c5566ee6d66b29d7441c83d678c","30dea2609dca9a360f0e931232726a20ede0c6f899850c3d4bc52a3dc1e2b561","55cd0bd6cf72feb7e6e960f8c596e1483f4995e42ddda0e9e80f7ced20e52d17","150292cdf3f3e70255b2c1f85b9b8f63a2a0cf4e05bb122245379f9cc679eb91","42c4aab0c41657d86f1d56a501ffe45c0c15637581aff73f35dd20b13f24c1d1","61ead6416ede483d172d30278d7aecdb34608875c6ad8075efd48aa5088f1c04","170ca59e43a658a2370d37a2c1d93cd1f00484dc79af0bf00a913b99c9f11479","9099e46e8a64460bf425993e5fe262d58b6b82c0f2e3b81136be3a4fe1432949","a2cc142e428f9ba66e267d5a54c1d31944d7caaea6d327f71ba0157eb8242a96","c0d92705e64e1fb79a9409bdc0f52ffb4558d2bfd9bc1271f7bb8b08d1662586","ce6c437154dd820cba6d2ba65fc5346e9211e5ba1917581f0e655abec11eb585","2b23b616c4f8d100f77962e1dceb98e00d9a561fd177b351ad6b301952e8c532","7c1a07ecd0c0622eeb6f8855d6d207d5e85bed86835c16f1ed7194187e2d1397","38d937ce98b75a57504863c0b5002a299654c40f50c3c1541740d44023a33492","ec816fb54abb5524e31d73835bd3d6eaca5596a3e007a57c25c7847880df18f9","758b7a408bffb38ec1b9d4af89d4108ab234dfe8adf3fadcd9b6c257394dcd9e","956471645863eff9170cf1379943ee529c0d247f355fb92af600cd43b21d07d5","9778d5830e567dfae40efff44c086f3d4d0f399fdb363d7a1a0ed98fb06df6f3","187f2d9e415ce7abab46a3634a301e62ba98a29cb1501e234e38b56943ef7e22","1722c295161ff9bc3bf38845c9206e8dd3e1cfc3b82e6bd857775e3de4a92669","ba35290bb1441d7b44cc53070cd800db09477ef8bebf28291a922d1dbcaf3d73","72f34ebbcf20fc938057f3a3655572524dd68bfde2e6cc67443092915fece58b","c1104abf29eb440fba0ef9b812686c7898a73a0845bc6faf4c7bde874f467c56","84cf3e75e1330199048cf834e369f098903cfcdd83443b12f6f688856f08634f","ee9cb256efe974b5fc937e162a785507d0a1bbc1b3809d40af73f6e51f7658f8","38e4b01187ae25d550c676d3e8cc3d0b34ba1530044a5158c2a02ca7b4785d4b","1fd48a38b0dba3a893369e3bff6ce7949e3a9cc6e3e4870621a002a5d5f1a2e6","c92a27c527253d48233262e08e4b630c55c49ac8b3e062525efa107514450a14","98ff8c0c96f046d554669f732cc8c0961bb3a1547021d11d3a72aea869c4db35","26ebacb6a4b9885cef2e930018cb8a30f0f5a8bdea47fce8b47da0cb53e10143","3d3b410f3f85e6fc21b0e2f821741444c1cf3242a3746c5779d9e10b32014155","ae770e479852941d6784e9767b2085d6a27245d87fddb0b4f9bd4cd8184910d9","d5a0a3f9507ccdeb4f564993b6dccf49584b66d9f033f7071dac4a9a2c0af8ba","5056a51fc3c88080e11e64caf5590c5e14a2ea89d95a5942b307a4b5960e0cbe","553b5f1bc307438ee233436e20cfd513102486b79dfe59a124771d3edb6f9f50","d8fc4ec2d0cd0deeb6590f68eb2ab25e78a4fa7af8e0ef7720ffa4c14a095a4e","59018c310e53d422a90d55d586a9ea57efac73c41b69650d7514dafcf9afff04","5b62516fce6499766344d36dd94b65e9debcb92573dab95f40780df24b2575fe","9f02510e49387598a5e5c319b1d9d3ff9cc5a6d0f694cd80e4468575a337257c","58279bdea1929fa95ba5f4b071fda52a0cc16d2d19360d33e5b1df4567373f80","47f1313b18f39ef27804c80a0b20b0dff8e4b05a7e2043bd92085569192a8f43","4dedbb356f6b62c0048fc638297801004425146bb9ac6e3f12e24d42fcbb7be1","f2bcb48fb7b443d9918f6614e60d665163b2bfe51107e3b56a269b528bda0f50","839e7a64095ab8912e19bca8f81d98a014fadd5eeba6a4f8a93fdd83ba4873da","336bb7c22984b16b28ed3cc563369bd48cac5fb7adeb3008224e62bae7837572","7a953e6c0155339ede6c0ba766774cadca985899d1b59973584804f02059675f","2ab1f494f7d5bafd295dd2e9c4c51828f25a24b3c960210010eb06ef0109ad56","0549f8c74f795bc89c2f6c4b7ec8ba69e7202d1a27e2468eb4ed8f3f3cd70523","6e015e9d34b3d8785b7262f5be83543370c16e660230e55511179985b1199888","a449318f671d9217189eb64630d1b6fbe56ab9d96d35170fa20f3eb2e2b7f597","eed127b654e05febf5ea7c4bdcca07027635ad816d20e6d3a7eadeacb3c67d65","0c5b51d0035ce077b0b87d41561ad00bfc4422fb804c452834ebaaabf522fe66","d20a055930966feb14451486c4753ee34d5398fed91ba6173b0d7c2ed87bae5f","a1ed74c00fc95976e0f057bee1622cc023dd9baf7f7637723a32943d3acd023c","7b6f943de9f8faebd876e08b11d13d60cd6af58e78c1b645dd340634d04abc88","29652fa9ea1412562c4392cf549771755cfe4aafed7e1ef7d278b134f3a0ad75","1a46e9188fe165d6325527faa75786d1183d5e9d9d831bb07fb4713242aa692e","bd6e6822f505c84d0887ddd3d3eb5111cbb6c72198406edbe2e57a80e12fe90d","599071fcb4dc0a0d286c86ed5fe891fb7bf9019540d8580fdf6e6b7d5330a829","731bc30f1eaf7d49177582b2d56ae23b882a880e3d1da9837115baf0cd4223c9","a38156e576b327144742258f36ef4df7b9dd63c31807b5c001f1a7a2f1ab2e50","6b9ec6877205583d2667107ba842cf90a25d292689b11b1a227729f95efae6bf","d79c712fe30cf059a7bbbbc23a0f593366239e3fbbc97503eb28865ee64b9a1c","774a87128c3dce1f15648a18ecd77d615ce710e4bdbb36be62becd36a787afab","b5d5a08d463fd18eaff54f7d36f341eb2116ff3c067a344ff13b73f000eaf1fd","a0caf680569ddd3e5e97ee4a0bf54d5ec51e3bb7ca172f776c627e7100fd895b","edbe4e8fa7cec533e8e5e2348834a85521e1294f5ea0805b01c89cc9f546912a","1bc591a1c768b6deaaf2d2e345ed6f7603f55025f8180e34bad0a5a284a03928","e6b168023091e0b24da8bdb53d3c0853fcfd570e69fbf7da78dd78b4609f17d6","58db9c54884c6414e9d8e1a2279b8adb75d144c8d1631b0cddd4387e74661cec","dfcb7dff51efaf6d519e7095030e1a356f55b6cfb1223c1193b3c41c84e85622","3cea9f635ff8f4a3681aeaa243e188adadb046b8a1a9b5d77e2a2a2c637d4b6d","3606e92ccc1122414b9990801db5f8d4f850a80312bb9cc85290ba8d3029929e","2777425508ba1f4a63de35da5c9df0a02647634d2560f76fe9f85eec4684585c","bcf630b49106848930944ee5b1f64481cef5f19fe94fd96c35ab666491919dff","e6bf6ebdaf76c27c06097e190f6124efb387946fa9805e1f37815789792bcd99","e480634d6200dd59692ee939935263fd9aa9e4f9c8547888327cf2c6bd46fe5e","7822dec0f20a5c7e8a4f2b1ec507e13e90f8aff8c98cf2ba56695815b981bc7d","1e1d250468c2ac4ca6e8b198c3ce46b0fec11ad96484df4144cc206f17d09fb0","a3735071db3f29ae2c0f536014fea9bf345fba93f11f1e859c007c6489a1ee2c","a2a75a6597348e4affbd735abb6e65242d8f9ba01dd9eb4b767e43d14f5a2370","37ec421f604650fced13b55147a6bd4829fc4d615b81e9520bfb7b150d2757e2","e382be0b43b4d7a97a06ab8b7cf235675edd81a31f32e9c1e8bad89f80c7a4d4","b29ae2c4f16daefbb612e6f1a51c43618d9efe183c1918a7f58193861d736734","024bbf030e3a7b462c2a7aea00c171129320b91148c17f674a335fb754da6000","a4bc0bb1e6a486e6a8498d747d99e9757d54febb44ea42c1f6bb6f43d1b3c0ad"];

  // whitelist tiers
  public type WhitelistTier = {
    name : Text;
    price : Nat64;
    whitelist : [ExtCore.AccountIdentifier];
  };

  // order from lower price to higher price
  public let whitelistTiers : [WhitelistTier] = [
    {
      name = "ethflower";
      price = 350000000;
      whitelist = ["da1fae1e25a417ab70953983a0c83ae5d7ee68ea83b1ac7b291246a29c87cc04","d29028c05d4b3a4e54b2c9040dd6d5acf8d79308b28344898729a0de0a52b241","43bf49989a6ac24d7dc97c93cc9e8bfe2ac245cb61a93754c6cd816877a7e59e","67e748b7e98637e151e261306cb2a503a229f6b6fbac37bc7b29f67e5d3984a7","e2f3ea30711a84fc73be573dc190ce6cc1d823e3b66f5f2b801e08c0662287f2","022012e61adc127db33504a4184e06656c0f61a523775495917e5d9800d3755e","f08b37e12779213cb9009e5d002b3e6882bc4b25ff74c5fa495c5b59a8afa114","7768f524837c292350dc65d0dc9e3d74c4ecabdac079280af4ad300e67cc5c02","747b0cd2a9671ac975320eef57ab3a91bda305632a8e5cbb89fe48a494e9c3f7","4d3e6ffca4fa377c11ccedc34a3f1c394287a0a04387b2843eb6769923767d05","c84a11c0f6154832f4d69e3fe142660d4059d1d76d5d8435bd5b71111c87ff09","ca6bc042227e25ea571df4850bb19120c592eb4cf84da641f0045a44ed9310bc","e3a5b60cca9f3b91a7effc9386018e83862405444c2c2ec257efea2d6f7ead1f","7f334fe352b99977d73bca6b086fc0e16f9b190840adcde461dc4cd218aa4f3e","465355bbf7beb933bd45e634a8a022e680c5810451dbf7046f4a74fc423dfcf0","5aae9c137c15085469dae02dc15ae226744e3bbdebec8b8ea400573b1092cd72","9bd6fcfdb052b697af8b7a6b831f9c388905d1e2c01be46888a3576b17bf2e2d","418a582d08e394e40a77a495cdcec68b5eb9018ce1fbcb58dd7d6ae71fb6ef5c","9e3739b44e3dd394c25b6ef94d4f0a97d3014ee5c03ae4940a649fba6736f81d","5162c338d8077f7e49195c3074f703f210e91f1e83df7395154ca0a8cd1bd563","562776c779143ea78896f230065549c903673f7ca3be7b607a2b4252c28f77c1","9f6bf03df2ffd85ae3430d6ad6a8f15c1c5d2de046284d32467d05090210220c","499cf90db96a34889621aaaa5792944dd3eb97a7f7093b6663f168a38acd942f","1dd8835c59be0c699ad1c049acf0ee7e27d298f5587393293769c8a124faabf4","f916f9e15b228e6acccf85096397c042d897a4dd9f9c4c0fa412e530b0294b4c","805437fd52f05efb7eed4e7d839105271434cb5d2b5f9007cc6f2ea7162f3c4b","13823bda923ae4b669ae45735593a61cd7a365edadbb0ca2036da7e726c283a3","5f19a62071805c89376679309bc445d814cbc69bc30a471927219be3839ae9f7","962b90de0a53d3b50f2e6a872fe7fed939fcd78d95d3fbc0c69ba890a3617786","0867f5c07c7b1a437208f0b4c3253e49f0eade5b669c2a3ec8b406be40c5f6d0","c020064a09b770e927114824f032329499b996134fe02589969aa881a40a17b3","cf7049b9e4e3b5baeb096af384159a9a78a8d8af4bc746e6982890e3ce4874e6","dd55af973f3d80a9c83f56a588f16e54f25a131bf86b89cfe0273e7161663084","c94ce6b491dab6e2ef74a6ca9689a9e020ce078d6f1dcbaebf02944f84906f9e","ad3ba1ff19d4c6abc61213502f79ee2c86e856dcf667b34779b2486fca9c7f6d","5fb8aa6c815aec75ec8cd5619e468a2ef4fd4a899c067c242250c08e368d4ca1","551e608c8c0051b93088089c40609471c5a411fbe6a913507a0f405e80638cad","64f4b148db6739e469a3ca9ba9127cac67c28742b659456f95374ff363c19cc8","e3eb7d31b260c4f9a5e83edce74268dcd918f0a78f0dfd8344fdcd4eaab70b0c","8445235227bd171321c8dcff4d985698688c41c3cb320602488a15055d489b87","63e2b2e4c8a0ab0c62bafbc366bc87c0f65155aa7957f1be54c7b8800b652e9a","b105a737b080da7ed6d9d80057ad87a3d8854fdeecf84fd16825144eb5e451ad","0dd1a0f0bc769396ab96482f4a9644afe42a2ac76105eab6fe57265c15a52450","07054dc6040a407478601619f9078305f165eef5d41f031fb6032a9573409f4d","5d1193c58f422fb0abc3aff1f8ea18e5bd3a0a69f09a1eb8986340f93c7efd90","7c84d01aed0eb5d928907cf3b2d6c8e44009cb0ef7107faec874b7fdff752b0a","da1ebe46c845185c511c65d3651bae3239816b72bd586a27152302e6b1da0022","be4744ce9f1608e1ee07c6d9634126e40ee1bf5586e87125efbec147cbc2a5aa","f6f5e85b7bf0617b7f3a72189b5fd52e2aefe0a95ae8f46e20ede09b32c206af","385fe989f72a3517731507e5794eaa9a24df1dfc680ab890436f236c69404cee","56206624ed53ebd7b3064c2358c9d1b7caa1d6e0e38d171b1f5c92bf2b45629e","8c9118c9a4a793a1e458a777782fd10705abe5b54b3da97abc42d51f930e8b6d","0dc9142c1fc33a238420fa4e650a742d82d7d00ccfbacde523a2f2939125264d","88d4342661b4d039111a9d019246088bf1a73084a861128ad4d371895efee382","58f85bc6b7e3f7264ba80e81648b2048383b3f8362f9544864d5cf249db5a230","ab5451cc5722d7424768025a3c5dcf174d6aaf3ccd4919ea939db579666a4d65","4326c692adc1df2e0601d4633c3efe8b2e5c88721bda0bc5662ccb190e5598b1","5c93d1de7ad583f679b58b3e7e975d22e28a5217fba9adb4e0d4494f990c2815","9bce124240d0a05a2b31185beb0d2cda4cb7c7732e6b4f0385eb42d8a4da0b80","413e90298c4ab6264dcdf46d81fde91959ff250258fe6d2d9c3752e31c881829","e544af97d7c552cb9d7919e52923ada5fa73dee95d748c23ca7c61574ca18865","722bad4c51f932f4070705f29c8d42b491135f37f9a1e9b6263c3330b705f906","dde455cfd598b64ce269b90a3e258d276be053aa06cacf652346d16e3f83dece","8cb3940db28a0afa075683dc43e7500e535fb2c95ecae52dd85f0d9bda72ff70","03f3377c89067c09c5d917a96a0c7aeca6dbb5c259c371640116ba352daa4d6e","4c2a85138dd9d4d63bf71d644f5ccd639e0c57dc5a6cd536e6774b46ff315bae","103cc36c7d626350afd7fd4d67ab1dbd52a33dd6752c7d348c85a91034f1d184","ac2feb1208c15672d0b67dfed861225eb9d7e1b2d2492d390fede52a89b0abe3","2ae49af121c19c78f50cc227b0553eabbf926cc6bc083d08c8f3e239555d18b1","1e7bfcc5b6939178a3b1d59d1dc7e7432a45f43b25318323e370150760eaec8c","e8f646b839646195ec789f5f94113115bdb2075393278515627fcee5fb9a3588","7bc09f332d4140d1096c6302e02a9df32d15daf79044786335c92b965e85d149","7de43f94a9292a4a30f3a92485c8e61c08f767911f85523c6224636df56bd6de","aa67b967eaddcb94044967a378710e5fb3bb219d922af8992e4af9c9b9df471b","6931085585993ccc46d747b34f01516b50767850cae66446550545055371b3cc","99fed1f9964cf1eedee16fe6b05b9ab4cec29a542b0aa615ce68af4ba7efeb75","faa83d07cc9e2db6e9dcae45d070a94be24c7679710a967283698bf1f6703d1b","f5b6924fa8945f44d4d6a722c7c17bfb43a7c6ad928fc4ee8a18342a805dcf2b","3ede79f08c1614e99cbb34ba842130465e07eb6921e6ee8dade7b3f1e185df82","3a28c47c39a4d48fc8ab44b20ad7d2d89064458c0e1b9d99bff8eb4a6bbe6f9b","e6f3fe674a197ff2e1ef9718ea769a0417035eb5f501cd66c39fafcdac84c883","66fe202ffb4298102e56e611e6e1be70e1b9318d58b5da21541526107997329a","7a91e401596f1bdc1b6c466e44cc2f42aa3e16b9487c6573e611b71f71755996","9eeb9e47f7b2e885ca0aa816e89243abb972a99442ad4be0db2687d90522a192","89991231c04c9eeeecd1738df57e1ef66f9746f2fac130c346c189ce808ea2a1","e7f7edf712ac7b1860771385805d59d20c4ee0459d4cf069508e003e6bfbc33a","343323210b632c1de7f2cf448a4970806c042090f7c19c82960bc0209dfc9ebc","28401a62ef598c55c82ce87a2904586e15e7862d62fa783039cf6e3925152492","148e1ade74facc230e7ab549730b784ccd8e2d6d75fbee0c8f95f7939e0a4f1a","79752e32ec0116b97a6b6857c6e18860acab8f13fee5b6cc342bf8b894b8f720","f712408f3b317d350b7d8a48e8ffab633461fc53fb86f5d6378423013b0fad69","5eb3d490d5737e69b16b69de93e4efcf51afb72f7a8c9c463cdd5cb87d2f20eb","4d49b50492718b267fb9f5c5b76dc1a83eb8522f97032609e450d8ae5e65ec1e","408b15be780eac3811bff9c606a4a3f1d4e2365852d3362b1827d25daecc99a0","973a0893bcb8b031123754b83f0790555985153d48947c10e25b09ca08fd4622","6254e50404ce2a81c5ae82ed21b1a0f254e56c2c99d3cfc23c724c30f45eb907","088f14250dc7229793fb40b417e91b46628768c3094c8384b3992aa20b025c23","5d27253dfc7e4794fb7621099c8d9e903ddd10215c12998639efdc087fdbfbbf","4dc6db0a9f845d6ee1e096ee4b07da3c89a9069d3df011f8d4f4f92b99eb8be5","ff7d32fbf4d5eaaea9d3223251261de071b1a6be3d69a1e94d8d7286d71d2301"];
    },
    {
      name = "modclub";
      price = 500000000;
      whitelist = ["b35858170c410ce65ae3dc9d36298766aa36d287854fe43dcb65998f19bc5881","68b9a81e80a707742e8639d92e69e629734c1bd7da330a7bef67247f80ea72dc","e9a5963080ece74caa4f799f7edfb469383f489427c05baa0ce3936d3552bd69","1dcf2932101e2f4ab453eb8c6a4bac692f4698d02509482c982027b157627cd7","856b2784f3b293a0257a8250490f64b5bea7855158e440f433efa9fcb2aa93cc","5f2e86d837b90f6dbd38be922d3cbeee8bc5734e6f283fc7290c7fbd222ffdbc","25baafc61173510143682d577d4fe06a018ffbd304b97c16d72dcf7c76f90d9b","360ddd1c4bf11ecf74f9d4e5970b3074c760417d09b2167c4579d7f752e20de9","e6c13c6004b4e2ee4031b86be2a3a4312dfb367889cd83c0283bc8d29859e427","d00df7eab5e813fa15efc9fbc54fef6c3b22b7765210170fbdebe17dafb83876","ee54b7ed429a8717f6a8c617a400432c7df8b2b0a90f4885edf872cac5f378bc","b6ab059c2e6e79b90015e657914630fae2eb4b492c94938144fe7c1e96e165bb","84fab60a013869ab13670320fbe25e422df843c43797b2b4fe77f2a4e74cfb81","f817e8f61529826df59726c7fc98246a2069de643cf7da84dece5bec3a0404e3","1f732003ac708c253286c1901aac017c486eadb263ebb1e62a7c690b5a80f2c4","c37124572d1a07399ea6628324dff40f82b0bc41a4d5f381345799c8aa0a29fc","acb7c6c02348e6094c8ab40d4742b5de50c07d23049c351c116cebdcfae231db","224a657bbbb3b72638ac6b70964ebb7fc80756b9ef21a263fbf66ede2d39d05e","88d295ecfead4014c378cc76787461bc90ba068b0f2351803c29f163e8446193","607699958c51e5ebb925ee980c22cafc2c65820fd94c03a8f4b7e4d733f6397f","a55c5c1dc10148282cc2ad5a79cf1c79a436460d2dab3589ff5d4701f4177fcd","82296efb49da3950fb1721a13e27e956bb474b409c987c4c5c16d9c98b337165","5656d099d6aa02fca3fa3dbe2bc4f5223d1bfc8c7979392faeba603eb9104680","51ef242cba3667646f07eb57fe735655eef790830f3c915befcbae3c84bbb47c","3225b7b37490fdd71aaf2a7028db973796508c2d1c67b95345067bfe1669000e","f4e0f95b5a2a9e49f15bdeacc08cba182ce6c65d6d914767b701425bfa7adc8d","9fed538e2aa89ca3a3a95abdfb7ddff9305e9d2ffbb375dc52f480b67fdd5d12","2ac33815f243813efaaef2681637af98320d98f58da75e09e25cc5934e7a856c","1adaf262c96f07fc85d771e3bccc7926b188cf67889f09294c5563934873a474","f374845867b578e0e72c69291c4cfaeaef85f171144249a86edb3da5cd43fb02","782def0ad4c53d573b902f9e38c0339ca1dc058bd33bf74ba46c7d0fbfcf8b5c","6897b22bfdcad80ef1192a4440e6baa51818fad9e83e44e3ccbc2f08986a8be6","2995cbd008d7d2814bfbfdb31550c4ed3d03835b3279126c1d6bec7e7e5ced75","b688504286eafcde2bb4c13e5a2502ed07ae5865458a4b452c93481378049a07","5e370db14e87d4b58c77813553d86e7fe296c688e5e143d55c5e8aea2bc88d68","f56978bab9d12ca7dff04242346e9d92cf683cf5158fc40e851e0eaeb7cd35b9","5071840ac395a38960ed442460f5c3eceb403c936a29c6e9d49770766b675b95","3859ba63b0c8132500f7569f1cf0f43cb2e3d008b712e0d1dc7caf9a84810e74","08a902cd6e20a8262cc3a30db7b0de11c45e5092f1ec9c1cba9f3547caab9964","802be6f49403d052a02a7fb15a3bf4a613a744c565c6176a4b40b452c4c5624a","564d25210b3a110aa5251e19645d609cff0212583be8347f94d47f9d2905520a","03701994bff826151847c4ce11424c7ab3f553bdbe600f4b7d61398c23ad17d0","0edcda345955bc57eca824b6e48c880c475a27072d7dad34e77af6ad9ccfea27","d0c13e8e67bff5c8664412bf15ca6391e7d67ca4cc911fa3c3257c6d094fac40","817b8bd7821856a8e9112187045c601739e5a0d405b66ec553b7c0defe05d5a6","c7af29a862c0839ddeeaf9a54b4ea1bfec8b2a1f3950a4082b48be072e4b4edb","d31802cc42e3032a06a663148eb72089def4ce6c8ed150fa84c032bfc6c891cd","947bb57c534f7525f92ddffa615020686f1d924c8efac0c2eb8d47339143ff7f","869fbfe76e50d83fd8934b89980481c7425a35a2189b863c9419ed2a8502d4ea","a6dc21cd38e119f4c6cda06202c8b05ed70d5d6dd349f3de1f898721f8251ff7","ccd101868c826d7f11286230f6553647b52f715a4cb2bb4b351f6c0925e99099","2ed57270f9777803eba344cc3d4037070e4fa9d602dcabc4c55c8c1fca68bf16","859495d399bb04dfca2465c75a1c5b804172833f66c543878f291e57910b6716","b6cf925a8fa2b829d44904571bfcaf5d7736d58777b9fb9c3258a4cc9057c54c","0eb1f9ac7435323d1240171876d038e1d58f3f725c870bb9f8fa6890db11db63","5b744515e35d35a17bba94f5afbeb539a17554410d456f2bab6556e415d1582b","cfa6a983f9d411a2c716ba51c991fb30e3ec5d732cb594f4115c61693e2f87a8","9e80ba8c8846bf27fa4d1fdc40fc58fecd4c297fe4897349a8359c80262fabe6","9d1ca3d499823ea807a9a472ddd790f8ff032102a7366a8c5053c2eb5c26067d","38e1be860308fb285234775d59ea36e66bd83de83c366a8271f3a05efc2e5054","f09060e829c04760ec82e280ea52ef8902c70cbc9ecc68f17423af545f2def9d","75a4de8d7ebbdbcd672b6525498c976f76c8145c28421a52013491b0e6e20b03","ac516f23910391516a72c81db0220bb2c3b193f957485c5d86820dde032d2bb1","d8ef087ac011df1a70d7a5c78c3ab58732e86b02dc837d3391a7d849e36607c4","71bd34ddd9a44829c9a532c8c53aac21cfe13b6671e5586e473739e9550aeae2","3ebd7fc6285b8d4083903314a6ff9fb8adebb50804d1441dbf4cd31c146c5dff","c79a2a710f88cc9aef65c6808bc11d9bd40744f381cbc1d31cb393dcf1a3aaf4","7ccdb45133d887ea237f125b6a106763ce8b024f94b18247002923a1d674f98a","ab510058846b884fcd53a2c430b12c4a2cfa7bb3c38af50cc513743d5cfc4266","cadf5a51765ed65fdae61768d3bf853817480dfc5fe61fee1fdf4d9aa90ff63f","70452a2a22e9da680350c4398b2f1d3bf44188c8a76015dba0cab5253ecd9a9b","0d4d1b6cc277a6ca508d3728fa1dd98e700b6e3313b573eff3acdf60331a7069","d72694b0fb5d8314eff6eb56e3d138db607d44e32ebf03aebf13e965bb8ce985","b20f2d5e2a1f9ffccdffd5ff825a5941cec32c718ea222adb718285363974e6a","8c4aeea243ec8eba0588662b910106f821d20638e7c3fc81b97975efe8cb1a0a","2433a2a9ee8ff11a56f8ab294a29fd6fdf8d257d5cd51a8df60733378d12db22","0588d74cb4fd81784da1e2e7936c355a9bc0cac2b1127a559883ea154cf717dc","f440990d3b1ceb4d5452704f16a0731f66b98371e48fd1593de207f4da7fc985","2c67e2f304bcc03f17454a49b7f2a99045d829bcf5657f4df58877a74cdb6074","233c4112fadd569f3c0a9c01cb71f926220b202870f37a8d66aadba16243c6a0","0c06846cd26fe8d180db1456a5fb85b626eb8f06459891dc1c689de9d79b1d38","8fc6adda248df5263921cb85dd4cff6b921b4ecec6b01b1c7a78ba96fb6794ca","a2b68ecb24a7ebb03669027a765af14969ad2e9b54752002a33b997c2fbfc1e3","71161c77d9675211c4f702f8299cd287391fdd98b376e9146494dfe66624056c","f6cf11e4954e02098fd1d03e6105a51b3e2f383237e51b09f9bf0cc90c1d3b3d","2b44c21acde6eb7ba22b1d12a910034f72106dfec0f8ba9584eb94790052fcdb","817a811ea77fa14b3d653db558c5c93b57a580bdbd92ef0bfa08a3a393349012","a0cea99bb6656d25c454e399ad463327edacaed97f26d722993d2c6c39365c5e","5917097763428be0267ba9d5f84d4c0db563cbf80734d58652c8ecc89a8468b4","66c677eb61bddd5f897b1e7e31738bb8eaab58db9a4d433529ac6e4b8f5e0ba6","32f99496468066a2d9b3453e0172bc10470eb732e08f089787afd04459944293","addfc60eb9a73571c89768f9367fa6a86076a5b14ba4c95f65f9a4e4b784ebc7","5bdb8bca42fee7e5c00d2c69c151803508103c6dbce3854ab6f34e0a047f8e1f","6e7cda0ccf6edbc7cb38efceb9f35315744dcab2a840130bb5a256230b98dc94","cd53e1cb05d9bc42731a2a44c28135395053b1985ca902db242402926c958a65","b8445369ed3ab25fbdde89974390aa3d549cb864616b2b6ec0017305f95b0040","4df1b917e1e5daa7243493f445317e0c091aef18ed2a523b06dd8c48c28d54c0","10740925fea5a6cd5bc94af452a176305e8d7fe099d0591f82789131c2c0a945","16367df5500b493ce64e0242e88c0171c913212081e53ef9d03b3cec4fda0330","95b09c1d3b86ee7ff374d577458d2715fd6163ca812c3f19760218c67830d007"];
    },
  ];
};
