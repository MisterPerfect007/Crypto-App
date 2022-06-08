import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinInfoLineChart extends StatelessWidget {
  final CoinLineChartData? chartData;
  const CoinInfoLineChart({
    Key? key,
    this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: false,
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 100,
        minY: 29000,
        maxY: 30000,
        lineBarsData: [
          LineChartBarData(
            preventCurveOverShooting: false,
            spots: [
              FlSpot(0, 29000),
              FlSpot(5, 29200),
              FlSpot(10, 29300),
              FlSpot(20, 29400),
              FlSpot(30, 29500),
              FlSpot(50, 29600),
              FlSpot(70, 29700),
              FlSpot(100, 30000),
            ],
            // isCurved: true,
            barWidth: 4,
            dotData: FlDotData(
              show: false,
            ),
            color: Colors.green,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.4),
                  Colors.green.withOpacity(0.0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
