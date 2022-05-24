import 'dart:ui';

import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/app_bar.dart';
import '../widgets/single coin/single_coin.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: CoinPageAppBar(size: size),
      ),
      body: Container(
        height: size.height,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.red, width: 5),
        // ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SortingCriteria(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SingleCoin(),
                    // Container(
                    //   height: 200,
                    //   width: size.width,
                    //   // color: Colors.red[100],
                    //   child: SingleCoinLineChart(),
                    // )
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}

class SingleCoinLineChart extends StatelessWidget {
  const SingleCoinLineChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
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
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 4),
            FlSpot(0.5, 3),
            FlSpot(1, 2.3),
            FlSpot(1.2, 2.5),
            FlSpot(1.5, 3.5),
            FlSpot(2, 4),
            FlSpot(2.2, 3.5),
            FlSpot(2.6, 3.2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 2),
          ],
          // isCurved: true,
          barWidth: 2,
          dotData: FlDotData(
            show: false,
          ),
          color: Colors.red,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.4),
                Colors.red.withOpacity(0.0)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
          ),
          // aboveBarData: BarAreaData(
          //   show: true,
          //   gradient: LinearGradient(
          //     colors: [
          //       Colors.green.withOpacity(0.0),
          //       Colors.green.withOpacity(0.4),
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter
          //   ),
          // ),
        ),
      ],
    ));
  }
}
