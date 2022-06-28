import 'package:equatable/equatable.dart';

import '../../domain/entities/coin.dart';

class CoinModel extends Coin {
  const CoinModel(
      {required String id,
      required String symbol,
      required String name,
      String? image,
      double? currentPrice,
      double? marketCap,
      int? marketCapRank,
      double? fullyDilutedValuation,
      double? totalVolume,
      double? high24h,
      double? low24h,
      double? priceChange24h,
      double? priceChangePercentage24h,
      double? marketCapChange24h,
      double? marketCapChangePercentage24h,
      double? circulatingSupply,
      double? totalSupply,
      double? maxSupply,
      double? ath,
      double? athChangePercentage,
      String? athDate,
      double? atl,
      double? atlChangePercentage,
      String? atlDate,
      String? lastUpdated,
      SparlineIn7d? sparklineIn7d,
      double? priceChangePercentage7dInCurrency})
      : super(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24h: high24h,
            low24h: low24h,
            priceChange24h: priceChange24h,
            priceChangePercentage24h: priceChangePercentage24h,
            marketCapChange24h: marketCapChange24h,
            marketCapChangePercentage24h: marketCapChangePercentage24h,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7d: sparklineIn7d,
            priceChangePercentage7dInCurrency:
                priceChangePercentage7dInCurrency);
  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      image: json["image"],
      currentPrice: json["current_price"]?.toDouble(),
      marketCap: json["market_cap"]?.toDouble(),
      marketCapRank: json["market_cap_rank"],
      fullyDilutedValuation: json["fully_diluted_valuation"]?.toDouble(),
      totalVolume: json["total_volume"]?.toDouble(),
      high24h: json["high_24h"]?.toDouble(),
      low24h: json["low_24h"]?.toDouble(),
      priceChange24h: json["price_change_24h"]?.toDouble(),
      priceChangePercentage24h: json["price_change_percentage_24h"]?.toDouble(),
      marketCapChange24h: json["market_cap_change_24h"]?.toDouble(),
      marketCapChangePercentage24h:
          json["market_cap_change_percentage_24h"]?.toDouble(),
      circulatingSupply: json["circulating_supply"]?.toDouble(),
      totalSupply: json["total_supply"]?.toDouble(),
      maxSupply: json["max_supply"]?.toDouble(),
      ath: json["ath"]?.toDouble(),
      athChangePercentage: json["ath_change_percentage"]?.toDouble(),
      athDate: json["ath_date"],
      atl: json["atl"]?.toDouble(),
      atlChangePercentage: json["atl_change_percentage"]?.toDouble(),
      atlDate: json["atl_date"],
      lastUpdated: json["last_updated"],
      sparklineIn7d: SparlineIn7d.fromJson(json["sparkline_in_7d"]),
      priceChangePercentage7dInCurrency:
          json["price_change_percentage_7d_in_currency"]?.toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "symbol": symbol,
      "name": name,
      "image": image,
      "current_price": currentPrice,
      "market_cap": marketCap,
      "market_cap_rank": marketCapRank,
      "fully_diluted_valuation": fullyDilutedValuation,
      "total_volume": totalVolume,
      "high_24h": high24h,
      "low_24h": low24h,
      "price_change_24h": priceChange24h,
      "price_change_percentage_24h": priceChangePercentage24h,
      "market_cap_change_24h": marketCapChange24h,
      "market_cap_change_percentage_24h": marketCapChangePercentage24h,
      "circulating_supply": circulatingSupply,
      "total_supply": totalSupply,
      "max_supply": maxSupply,
      "ath": ath,
      "ath_change_percentage": athChangePercentage,
      "ath_date": athDate,
      "atl": atl,
      "atl_change_percentage": atlChangePercentage,
      "atl_date": atlDate,
      "last_updated": lastUpdated,
      "sparkline_in_7d": sparklineIn7d!.toJson(),
      "price_change_percentage_7d_in_currency":
          priceChangePercentage7dInCurrency
    };
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCap,
        marketCapRank,
        fullyDilutedValuation,
        totalVolume,
        high24h,
        low24h,
        priceChange24h,
        priceChangePercentage24h,
        marketCapChange24h,
        marketCapChangePercentage24h,
        circulatingSupply,
        totalSupply,
        maxSupply,
        ath,
        athChangePercentage,
        athDate,
        atl,
        atlChangePercentage,
        atlDate,
        lastUpdated,
        sparklineIn7d,
        priceChangePercentage7dInCurrency,
      ];
}

class SparlineIn7d extends Equatable {
  final List<double> price;

  const SparlineIn7d(this.price);

  factory SparlineIn7d.fromJson(Map<String, dynamic> json) {
    return SparlineIn7d(
      List<double>.from(
        json["price"].map(
          (x) => x.toDouble(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
    };
  }

  @override
  List<Object?> get props => [price];
}
