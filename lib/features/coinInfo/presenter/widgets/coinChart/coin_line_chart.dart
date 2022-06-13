import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
          handleBuiltInTouches: true,
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(5),
              tooltipBgColor: Colors.grey.withOpacity(0.2),
              fitInsideHorizontally: true,
              getTooltipItems: (touchedSpot) {
                return touchedSpot.map((spotData) {
                  return LineTooltipItem("", const TextStyle(),
                      textAlign: TextAlign.left,
                      children: [
                        TextSpan(
                          text: "\$ ${priceFormater(spotData.y)}",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        TextSpan(
                          text: "\n${convertTime(spotData.x.toInt())}",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              color: AppColors.mainGrey,
                              fontSize: 11,
                              height: 2,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
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

  ///Custom method to format price for a correct display
  String priceFormater(double? price) {
    if (price == null) {
      return '??';
    } else {
      if (price < 0.9) {
        if (price < 0.09) {
          if (price < 0.00099) {
            return NumberFormat("#.${'#' * 15}", "en_US").format(price);
          } else {
            return NumberFormat("#.${'#' * 5}", "en_US").format(price);
          }
        } else {
          return NumberFormat("#.${'#' * 4}", "en_US").format(price);
        }
      } else {
        return NumberFormat("#,###.##", "en_US").format(price);
      }
      // if (price < 0.00099) {
      //   return  price.toStringAsFixed(10);
      // } else {
      //   return NumberFormat("#,###.##", "en_US").format(price);
      // }
    }
  }

  ///Convert and format time from millisecondsSinceEpoch
  String convertTime(int? millisecondsSinceEpoch) {
    return millisecondsSinceEpoch != null
        ? DateFormat('dd/MM/y hh:mma', 'en_US')
            .format(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch))
        : "??/??/????";
  }
}
