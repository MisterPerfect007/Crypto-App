import 'dart:math';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinLineChartData extends Equatable {
  final List<double> dataList;

  const CoinLineChartData({required this.dataList});
  @override
  List<Object?> get props => [dataList];

  double get getMaxY => dataList.reduce(max);

  double get getMinY => dataList.reduce(min);

  double get getMaxX => (dataList.length - 1).toDouble();

  /// Return FlSpot list
  List<FlSpot> getSpotList() {
    return dataList
        .asMap()
        .entries
        .map((element) => FlSpot(element.key.toDouble(), element.value))
        .toList();
  }

  /// Return the LineChart color
  Color getColor() {
    return dataList[0] > dataList[dataList.length - 1]
        ? AppColors.pureRed
        : AppColors.mainGreen;
  }
}
