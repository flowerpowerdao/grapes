# Configuration
Collection canister is configured via `initArgs.did` file.

Customize `initArgs.did` before you deploy the canister.

## Required settings
```candid
(
  principal "rrkah-fqaaa-aaaaa-aaaaq-cai", // your canister id
  record {
    name = "Collection Name";
    sale = variant { supply = 10_000 };
    salePrices = vec {
      record {
        ledger = principal "ryjl3-tyaaa-aaaaa-aaaba-cai";
        price = 700_000_000; // 7 ICP
      };
    };
    publicSaleStart = 1680696181381000000;
    salesDistribution = vec {};
    royalties = vec {};
    marketplaces = vec {
      record { "entrepot"; "ccfe146bb249b6c59e8c5ae71a1b59ddf85d9f9034611427b696f8b25d7b826a"; 500 };
    };
    revealDelay = variant { hours = 24 };
    airdrop = vec {};
    whitelists = vec {};
  }
)
```


## Name
```
name = "Collection Name";
```


## Sale
1. Fixed collection size
```candid
sale = variant { supply = 10_000 };
```
2. No definite collection size and can be minted within a given time (starting after `publicSaleStart`)
```candid
sale = variant {
  duration = variant { days = 30 };
};
```


## Sale price
```candid
salePrices = vec {
  record {
    ledger = principal "ryjl3-tyaaa-aaaaa-aaaba-cai";
    price = 700_000_000; // 7 ICP
  };
  // other ledgers...
};
```

## Public sale start
When public sale start time in nanoseconds.
```candid
publicSaleStart = 1680696181381000000;
```

## Sale distribution
Sales distribution.

Total percent must be 100%

1000 == 1%

```candid
salesDistribution = vec {
  record { "<address1>"; <percent1> };
  record { "<address2>"; <percent2> };
  // ...
};
```

Example:
```candid
salesDistribution = vec {
  record { "k2t6j-2nvnp-4zjm3-25dtz-6xhaa-c7boj-5gayf-oj3xs-i43lp-teztq-6ae"; 55000 }; // 55%
  record { "dwx4w-plydf-jxgs5-uncbu-mfyds-5vjzm-oohax-gmvja-cypv7-tmbt4-dqe"; 45000 }; // 45%
};
```

## Royalties
Secondary market royalties.

Typically, total <= 10%

Example:
```candid
royalties = vec {
  record { "k2t6j-2nvnp-4zjm3-25dtz-6xhaa-c7boj-5gayf-oj3xs-i43lp-teztq-6ae"; 500 }; // 0.5%
  record { "dwx4w-plydf-jxgs5-uncbu-mfyds-5vjzm-oohax-gmvja-cypv7-tmbt4-dqe"; 300 }; // 0.3%
};
```

## Marketplaces
Allowed marketplaces.

At least one marketplace must be specified.

First marketplace is default.

1000 == 1%

Marketplace royalties are paid out twice. One to the seller marketplace(where NFT was listed),
and one to the buyer marketplace(where NFT was bought).

If an NFT is listed and bought on the same marketplace, it will receive 2x royalty fee.

```candid
marketplaces = vec {
  record { "<name1>"; "<address1>"; <fee_percent1> };
  record { "<name2>"; "<address2>"; <fee_percent2> };
  // ...
};
```

Example:
```candid
marketplaces = vec {
  record { "entrepot"; "ccfe146bb249b6c59e8c5ae71a1b59ddf85d9f9034611427b696f8b25d7b826a"; 500 }; // 0.5%
  record { "yumi"; "ccfe146bb249b6c59e8c5ae71a1b59ddf85d9f9034611427b696f8b25d7b826a"; 450 }; // 0.45%
  record { "jelly"; "ccfe146bb249b6c59e8c5ae71a1b59ddf85d9f9034611427b696f8b25d7b826a"; 300 }; // 0.3%
};
```


## Whitelists
Place the nearest and cheapest whiteslist first.

```candid
whitelists = vec {
  record {
    name = "ethflower";
    salePrices = vec {
      record {
        ledger = principal "ryjl3-tyaaa-aaaaa-aaaba-cai";
        price = 350000000; // 3.5 ICP
      };
    };
    oneTimeOnly = true; // whitelist addresses are removed after purchase
    startTime = 1681992566953000000;
    endTime = opt 1681992566953000000; // can be omitted
    addresses = vec {
      "ccfe146bb249b6c59e8c5ae71a1b59ddf85d9f9034611427b696f8b25d7b826a";
      "a6da832e6f11f4848c6a533f05f3f1c8ed20e948503931a380523718fb215887";
      // ...
    };
  };
  record {
    name = "modclub";
    salePrices = vec {
      record {
        ledger = principal "ryjl3-tyaaa-aaaaa-aaaba-cai";
        price = 500000000; // 5 ICP
      };
    };
    oneTimeOnly = false;
    startTime = 1681992566953000000;
    endTime = opt 1681992566953000000;
    addresses = vec {
      "ccfe146bb249b6c59e8c5ae71a1b59ddf85d9f9034611427b696f8b25d7b826a";
      "a6da832e6f11f4848c6a533f05f3f1c8ed20e948503931a380523718fb215887";
      // ...
    };
  };
};
```

The last whitelist `endTime` is typically equal to `publicSaleStart`.


## Airdrop
```candid
airdrop = vec { "<address1>"; "<address2>"... };
```


## Reveal Delay
How long to delay assets shuffling and reveal (starting after `publicSaleStart`)

`variant { none }` - assets will be revealed immediately and assets shuffling will be disabled

```candid
revealDelay = variant { hours = 24 };
```


## Settings with default values
Default values are used for the following settings if they are not specified in `initArgs.did` or equal to `null`

```candid
// true - the entire collection will consists of only one asset, meaning all NFTs look the same
// false - there are at least two different assets in the collection
singleAssetCollection = opt false;
escrowDelay = opt variant { minutes = 2 }; // How much time does the user have to transfer ICP
marketDelay = opt variant { days = 2 }; // How long to delay market opening (2 days after public sale started or when sold out)
timersInterval = opt variant { seconds = 60 }; // Interval for sending deferred payments
```


## Dutch auction
Default `null`

```candid
dutchAuction = opt record {
  target = { everyone }; // dutch auction for everyone
  // target = { whitelist }; // dutch auction for whitelist(tier price is ignored), then salePrice for public sale
  // target = { publicSale }; // tier price for whitelist, then dutch auction for public sale
  startPrice = 21500000000; // start with 350 icp for dutch auction
  intervalPriceDrop = 500000000; // drop 5 icp every interval
  reservePrice = 500000000; // reserve price is 5 icp
  interval = 60000000000; // 1 minute
};
```

## Legacy Placeholders
Default `null`

```candid
// true - the collection has the placeholder stored at the 0 index of the asset array
// false - the placeholder has its on stable variable in the canister
legacyPlaceholder = opt false
```

## Restore
Default `null`

```candid
restoreEnabled : ?Bool; // must be null (see backup/README.md for details)
```
