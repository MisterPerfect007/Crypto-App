import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:equatable/equatable.dart';

class CoinMarketChartModel extends CoinMarketChart {
  const CoinMarketChartModel(
      {required List<SingleDayCoinMarketChart> prices})
      : super(prices: prices);
  factory CoinMarketChartModel.fromJson(Map<String, dynamic> json) {
    print(json.runtimeType);
    return CoinMarketChartModel(
      prices: json["prices"]
          .map(
            (x) => {SingleDayCoinMarketChart.fromJson(x), print(SingleDayCoinMarketChart.fromJson(x).runtimeType)},
          ).toList()
          as List<SingleDayCoinMarketChart>,
    );
  }

  Map<String, dynamic> toJson(prices) {
    return {"prices": prices};
  }
}

class SingleDayCoinMarketChart extends Equatable {
  final List<num> singlePrice;

  const SingleDayCoinMarketChart({required this.singlePrice});

  factory SingleDayCoinMarketChart.fromJson(json) {
    return SingleDayCoinMarketChart(singlePrice: [json[0].toInt(), json[1].toDouble()]);
  }

  List toJson() {
    return [
      singlePrice[0],
      singlePrice[2],
    ];
  }

  @override
  List<Object?> get props => [singlePrice];
}
