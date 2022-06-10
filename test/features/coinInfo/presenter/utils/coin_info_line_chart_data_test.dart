import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:crypto_trends/features/coinInfo/presenter/utils/coin_info_line_chart_data.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CoinInfoLineChartData chartData;

  setUp(() {
    chartData = CoinInfoLineChartData(coinMarketChart: coinMarketChart);
  });
  double tMaxY = 31865;
  double tMinY = 29714.143487149733;
  double tMaxX = 1654613148000;
  double tMinX = 1654041600000;

  test("Should get the max Y", () {
    final result = chartData.getMaxY;

    expect(result, tMaxY);
  });
  test("Should get the min Y", () {
    final result = chartData.getMinY;

    expect(result, tMinY);
  });

  test("Should get the max X", () {
    final result = chartData.getMaxX;

    expect(result, tMaxX);
  });

  test("Should get the mix X", () {
    final result = chartData.getMinX;

    expect(result, tMinX);
  });

  test("Should get FlSpot", () {
    final result = chartData.getSpotList();

    expect(result, tSpotList);
  });

  group("LineChart colo", () {
    test("Should return pureRed color ", () {
      final result = chartData.getColor();

      expect(result, AppColors.pureRed);
    });

    test("Should return mainGreen color ", () {
      final customCoinMarketChart =
          CoinMarketChart(prices: coinMarketChart.prices.reversed.toList());
      chartData = CoinInfoLineChartData(coinMarketChart: customCoinMarketChart);

      final result = chartData.getColor();

      expect(result, AppColors.mainGreen);
    });
  });
}

CoinMarketChart coinMarketChart = const CoinMarketChart(prices: [
  SingleCoinMarketChartData(singlePrice: [1654041600000, 31865]),
  SingleCoinMarketChartData(singlePrice: [1654128000000, 29833.450330205254]),
  SingleCoinMarketChartData(singlePrice: [1654214400000, 30481]),
  SingleCoinMarketChartData(singlePrice: [1654300800000, 29714.143487149733]),
  SingleCoinMarketChartData(singlePrice: [1654387200000, 29872.3603087139]),
  SingleCoinMarketChartData(singlePrice: [1654473600000, 29917.764052456198]),
  SingleCoinMarketChartData(singlePrice: [1654560000000, 31372.5847629755]),
  SingleCoinMarketChartData(singlePrice: [1654613148000, 29795.715918501694]),
]);

List<FlSpot> tSpotList = const [
  FlSpot(1654041600000, 31865),
  FlSpot(1654128000000, 29833.450330205254),
  FlSpot(1654214400000, 30481),
  FlSpot(1654300800000, 29714.143487149733),
  FlSpot(1654387200000, 29872.3603087139),
  FlSpot(1654473600000, 29917.764052456198),
  FlSpot(1654560000000, 31372.5847629755),
  FlSpot(1654613148000, 29795.715918501694),
];
