import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';
import '../../domain/entities/coin_market_chart.dart';

//tested class
// ignore: must_be_immutable
class CoinInfoLineChartData extends Equatable {
  final CoinMarketChart coinMarketChart;

  late List<List<dynamic>> dataList;
  CoinInfoLineChartData({required this.coinMarketChart}) {
    dataList = coinMarketChart.prices.map((e) => e.toJson()).toList();
  }
  @override
  List<Object?> get props => [coinMarketChart];

  double get getMaxY =>
      List<double>.from(dataList.map((e) => e[1].toDouble()).toList())
          .reduce(max);

  double get getMinY =>
      List<double>.from(dataList.map((e) => e[1].toDouble()).toList())
          .reduce(min);

  double get getMaxX => dataList[dataList.length - 1][0].toDouble();

  double get getMinX => dataList[0][0].toDouble();

  /// Return FlSpot list
  List<FlSpot> getSpotList() {
    return dataList
        .map((e) => FlSpot(e[0].toDouble(), e[1].toDouble()))
        .toList();
  }

  /// Return the LineChart color
  Color getColor() {
    return dataList[0][1] > dataList[dataList.length - 1][1]
        ? AppColors.pureRed
        : AppColors.mainGreen;
  }
}
