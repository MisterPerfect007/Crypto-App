import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';

const CoinModel testSingleCoinModel = CoinModel(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image:
        "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    currentPrice: 28679,
    marketCap: 543104784696,
    marketCapRank: 1,
    fullyDilutedValuation: 599081285398,
    totalVolume: 79710163025,
    high24h: 31841,
    low24h: 26597,
    priceChange24h: -3162.6128825599517,
    priceChangePercentage24h: -9.93243,
    marketCapChange24h: -60896114305.38214,
    marketCapChangePercentage24h: -10.08212,
    circulatingSupply: 19037818,
    totalSupply: 21000000,
    maxSupply: 21000000,
    ath: 69045,
    athChangePercentage: -58.62528,
    athDate: "2021-11-10T14:24:11.849Z",
    atl: 67.81,
    atlChangePercentage: 42028.73924,
    atlDate: "2013-07-06T00:00:00.000Z",
    lastUpdated: "2022-05-12T11:15:01.530Z",
    sparklineIn7d: {
      "price": [39509.42332989887, 39570.01981374774]
    },
    priceChangePercentage7dInCurrency: 13);


const List<Coin> testCoins = [
  Coin(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      currentPrice: 28679,
      marketCap: 543104784696,
      marketCapRank: 1,
      fullyDilutedValuation: 599081285398,
      totalVolume: 79710163025,
      high24h: 31841,
      low24h: 26597,
      priceChange24h: -3162.6128825599517,
      priceChangePercentage24h: -9.93243,
      marketCapChange24h: -60896114305.38214,
      marketCapChangePercentage24h: -10.08212,
      circulatingSupply: 19037818,
      totalSupply: 21000000,
      maxSupply: 21000000,
      ath: 69045,
      athChangePercentage: -58.62528,
      athDate: "2021-11-10T14:24:11.849Z",
      atl: 67.81,
      atlChangePercentage: 42028.73924,
      atlDate: "2013-07-06T00:00:00.000Z",
      lastUpdated: "2022-05-12T11:15:01.530Z",
      sparklineIn7d: {
        "price": [39509.42332989887, 39570.01981374774]
      },
      priceChangePercentage7dInCurrency: 13),
  Coin(
      id: "ethereum",
      symbol: "eth",
      name: "Ethereum",
      image:
          "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
      currentPrice: 1973.38,
      marketCap: 238204688907,
      marketCapRank: 2,
      fullyDilutedValuation: null,
      totalVolume: 56129052848,
      high24h: 2438.13,
      low24h: 1774.8,
      priceChange24h: -464.75212045184276,
      priceChangePercentage24h: -19.06184,
      marketCapChange24h: -54735742670.09357,
      marketCapChangePercentage24h: -18.68494,
      circulatingSupply: 120747263.249,
      totalSupply: null,
      maxSupply: null,
      ath: 4878.26,
      athChangePercentage: -59.60473,
      athDate: "2021-11-10T14:24:19.604Z",
      atl: 0.432979,
      atlChangePercentage: 455023.03107,
      atlDate: "2015-10-20T00:00:00.000Z",
      lastUpdated: "2022-05-12T11:14:14.177Z",
      sparklineIn7d: {
        "price": [2925.7546621681654, 2932.6198376355937]
      },
      priceChangePercentage7dInCurrency: 9),
];


const List<CoinModel> testCoinModels = [
  CoinModel(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      currentPrice: 28679,
      marketCap: 543104784696,
      marketCapRank: 1,
      fullyDilutedValuation: 599081285398,
      totalVolume: 79710163025,
      high24h: 31841,
      low24h: 26597,
      priceChange24h: -3162.6128825599517,
      priceChangePercentage24h: -9.93243,
      marketCapChange24h: -60896114305.38214,
      marketCapChangePercentage24h: -10.08212,
      circulatingSupply: 19037818,
      totalSupply: 21000000,
      maxSupply: 21000000,
      ath: 69045,
      athChangePercentage: -58.62528,
      athDate: "2021-11-10T14:24:11.849Z",
      atl: 67.81,
      atlChangePercentage: 42028.73924,
      atlDate: "2013-07-06T00:00:00.000Z",
      lastUpdated: "2022-05-12T11:15:01.530Z",
      sparklineIn7d: {
        "price": [39509.42332989887, 39570.01981374774]
      },
      priceChangePercentage7dInCurrency: 13),
  CoinModel(
      id: "ethereum",
      symbol: "eth",
      name: "Ethereum",
      image:
          "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
      currentPrice: 1973.38,
      marketCap: 238204688907,
      marketCapRank: 2,
      fullyDilutedValuation: null,
      totalVolume: 56129052848,
      high24h: 2438.13,
      low24h: 1774.8,
      priceChange24h: -464.75212045184276,
      priceChangePercentage24h: -19.06184,
      marketCapChange24h: -54735742670.09357,
      marketCapChangePercentage24h: -18.68494,
      circulatingSupply: 120747263.249,
      totalSupply: null,
      maxSupply: null,
      ath: 4878.26,
      athChangePercentage: -59.60473,
      athDate: "2021-11-10T14:24:19.604Z",
      atl: 0.432979,
      atlChangePercentage: 455023.03107,
      atlDate: "2015-10-20T00:00:00.000Z",
      lastUpdated: "2022-05-12T11:14:14.177Z",
      sparklineIn7d: {
        "price": [2925.7546621681654, 2932.6198376355937]
      },
      priceChangePercentage7dInCurrency: 9),
];

