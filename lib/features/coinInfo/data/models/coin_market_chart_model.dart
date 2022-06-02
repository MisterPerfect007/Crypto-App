import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:equatable/equatable.dart';

class CoinMarketChartModel extends CoinMarketChart {
  const CoinMarketChartModel({required List<SingleCoinMarketChartData> prices})
      : super(prices: prices);
  factory CoinMarketChartModel.fromJson(Map<String, dynamic> json) {
    return CoinMarketChartModel(
      prices: List<SingleCoinMarketChartData>.from(json["prices"]
          .map(
            (x) => SingleCoinMarketChartData.fromJson(x),
          )
          .toList()),
    );
  }

  Map<String, dynamic> toJson(List<SingleCoinMarketChartData> prices) {
    return {
      "prices": prices.map((x) => x.toJson()).toList()
    };
  }
}

class SingleCoinMarketChartData extends Equatable {
  final List<num> singlePrice;

  const SingleCoinMarketChartData({required this.singlePrice});

  factory SingleCoinMarketChartData.fromJson(json) {
    return SingleCoinMarketChartData(
        singlePrice: [json[0].toInt(), json[1].toDouble()]);
  }

  List toJson() {
    return [
      singlePrice[0],
      singlePrice[1],
    ];
  }

  @override
  List<Object?> get props => [singlePrice];
}
