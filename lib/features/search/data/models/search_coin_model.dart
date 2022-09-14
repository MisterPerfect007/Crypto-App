import 'package:crypto_trends/features/search/domain/entity/search_coin.dart';

class SearchCoinModel extends SearchCoin {
  const SearchCoinModel({
    required String id,
    required String name,
    required String symbol,
    String? image,
    int? marketCapRank,
  }) : super(
            id: id,
            name: name,
            symbol: symbol,
            image: image,
            marketCapRank: marketCapRank);
  factory SearchCoinModel.fromJson(Map<String, dynamic> json) {
    return SearchCoinModel(
      id: json["id"],
      name: json["name"],
      symbol: json["symbol"],
      image: json["large"],
      marketCapRank: json["market_cap_rank"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "symbol": symbol,
      "large": image,
      "market_cap_rank": marketCapRank
    };
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        marketCapRank,
      ];
}
