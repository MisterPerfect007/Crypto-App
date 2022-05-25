import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CoinLineChartData chartData;

  List<double> data = [1, 2, 3, 4, 8, 0, 0.12];
  List<double> data2 = [1, 2, 3, 4, 8, 0, 9];
  List<FlSpot> spotList = const [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 3),
    FlSpot(3, 4),
    FlSpot(4, 8),
    FlSpot(5, 0),
    FlSpot(6, 0.12),
  ];

  setUp(() {
    chartData = CoinLineChartData(dataList: data);
  });
  test("Should return the correct maxY", () {
    final result = chartData.getMaxY;

    expect(result, 8);
  });
  test("Should return the correct minY", () {
    final result = chartData.getMinY;

    expect(result, 0);
  });

  test("Should return the correct maxX", () {
    final result = chartData.getMaxX;

    expect(result, 6);
  });

  test("Should return the correct FlSpot list", () {
    final result = chartData.getSpotList();

    expect(result, spotList);
  });

  test("Should return AppColors.pureRed color ", () {
    final result = chartData.getColor();

    expect(result, AppColors.pureRed);
  });

  test("Should return AppColors.mainGreen color ", () {
    chartData = CoinLineChartData(dataList: data2);
    final result = chartData.getColor();

    expect(result, AppColors.mainGreen);
  });
}
