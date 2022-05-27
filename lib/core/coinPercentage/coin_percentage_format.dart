import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';

class CoinPercentageFormat extends Equatable {
  final double percentage;

  const CoinPercentageFormat({required this.percentage});
  @override
  List<Object?> get props => [percentage];

  bool get isPositive => percentage >= 0;

  Color get getColor => isPositive ? AppColors.mainGreen : AppColors.pureRed;

  String signedPercentage() {
    if (percentage is int) {
      return isPositive ? '+$percentage.00' : '-$percentage.00';
    } else {
      return isPositive
          ? '+' + percentage.toStringAsFixed(2)
          : percentage.toStringAsFixed(2);
    }
  }
}
