import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/coin_info_line_chart_data.dart';

class CoinInfoLineChart extends StatelessWidget {
  final CoinInfoLineChartData chartData;
  CoinInfoLineChart({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.grey.withOpacity(0.2),
              fitInsideHorizontally: true,
              getTooltipItems: (touchedSpot) {
                return touchedSpot.map((e) {
                  return LineTooltipItem("", TextStyle(),
                      textAlign: TextAlign.left,
                      children: [
                        TextSpan(
                          /* text: "\$ ${NumberFormat.compact().format(e.y)}", */
                          text: "\$ ${priceFormater(0.0001567)}",
                          style: GoogleFonts.inter(textStyle: TextStyle(
                            fontWeight: FontWeight.bold
                          ))
                        ),
                        TextSpan(text: "\nAAaaa nnnn"),
                      ]);
                }).toList();
              }),
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((e) {
              return TouchedSpotIndicatorData(
                FlLine(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 1,
                    dashArray: [3, 3]),
                FlDotData(show: true),
              );
            }).toList();
          },
        ),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: false,
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
            isStrokeCapRound: true,
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


  final numberFormater = NumberFormat("#,##0.00", "en_US");
  ///Custom method to format price for a correct display
  String priceFormater(double? price) {
    if (price == null) {
      return '??';
    } else {
      if(price < 1000){
        if(price < 0.1){
          return price.toString();
        } else {
          return numberFormater.format(price);
        }
      } else {
        return NumberFormat("#,###", "en_US").format(price);
      }
      // return NumberFormat("#,###", "en_US").format(price);

    }
  }
}
