import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:crypto_trends/features/coinInfo/presenter/utils/coin_info_line_chart_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late CoinInfoLineChartData chartData; 

  setUp((){
    chartData = CoinInfoLineChartData(coinMarketChart: coinMarketChart);
  });
  double tmaxY = 31865.749621173167;

  test("Should get the max Y", (){
    final result = chartData.getMaxY;

    expect(result, tmaxY);
  });
}
CoinMarketChart coinMarketChart = const CoinMarketChart(prices: [
  SingleCoinMarketChartData(singlePrice: [1654041600000, 31865.749621173167]),
  SingleCoinMarketChartData(singlePrice: [1654128000000, 29833.450330205254]),
  SingleCoinMarketChartData(singlePrice: [1654214400000, 30481.013996026013]),
  SingleCoinMarketChartData(singlePrice: [1654300800000, 29714.143487149733]),
  SingleCoinMarketChartData(singlePrice: [1654387200000, 29872.3603087139]),
  SingleCoinMarketChartData(singlePrice: [1654473600000, 29917.764052456198]),
  SingleCoinMarketChartData(singlePrice: [1654560000000, 31372.5847629755]),
  SingleCoinMarketChartData(singlePrice: [1654613148000, 29795.715918501694]),
]);