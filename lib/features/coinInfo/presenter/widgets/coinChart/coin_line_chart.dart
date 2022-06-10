import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../utils/coin_info_line_chart_data.dart';

class CoinInfoLineChart extends StatelessWidget {
  final CoinInfoLineChartData chartData;
  const CoinInfoLineChart({
    Key? key,
    required this.chartData,
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
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 10000,
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            // drawBehindEverything: false,
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: chartData.getMinX,
        maxX: chartData.getMaxX,
        minY: chartData.getMinY,
        maxY: chartData.getMaxY,
        lineBarsData: [
          LineChartBarData(
            preventCurveOverShooting: false,
            spots: chartData.getSpotList(),
            isCurved: true,
            barWidth: 2.5,
            dotData: FlDotData(
              show: false,
            ),
            color: chartData.getColor(),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  chartData.getColor().withOpacity(0.4),
                  chartData.getColor().withOpacity(0.0)
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
