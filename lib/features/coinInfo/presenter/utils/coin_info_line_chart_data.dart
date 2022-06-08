import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../coinList/presenter/utils/coin_line_chart_data.dart';
import '../../domain/entities/coin_market_chart.dart';

class CoinInfoLineChartData extends Equatable {
  final CoinMarketChart coinMarketChart;

  late List<List<dynamic>> dataList;
  CoinInfoLineChartData( {required this.coinMarketChart}){
    dataList = coinMarketChart.prices.map((e) => e.toJson()).toList();
  }
  @override
  List<Object?> get props => [coinMarketChart];

  

  double get getMaxY => List<double>.from (dataList.map((e) => e[1]).toList()).reduce(max);

  // double get getMinY => dataList.reduce(min);

  // double get getMaxX => (dataList.length - 1).toDouble();

  // /// Return FlSpot list
  // List<FlSpot> getSpotList() {
  //   return dataList
  //       .asMap()
  //       .entries
  //       .map((element) => FlSpot(element.key.toDouble(), element.value))
  //       .toList();
  // }

  // /// Return the LineChart color
  // Color getColor() {
  //   return dataList[0] > dataList[dataList.length - 1]
  //       ? AppColors.pureRed
  //       : AppColors.mainGreen;
  // }
}