import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';

class CoinPercentageFormat extends Equatable {
  final double? percentage;

  const CoinPercentageFormat({required this.percentage});

  @override
  List<Object?> get props => [percentage];

  bool? isPositive() {
    if (percentage != null) {
      return percentage! >= 0;
    } else {
      return false;
    }
  }

  Color getColor() {
    if (isPositive() == true) {
      return AppColors.mainGreen;
    } else if (isPositive() == false) {
      return AppColors.pureRed;
    }else {
      return AppColors.mainGrey;
    }
  }

  String fixedPercentage() {
    if (percentage != null) {
      return percentage!.abs().toStringAsFixed(2);
    } else {
      return "";
    }
  }
  String signedPercentage() {
    if (percentage != null) {
      return (isPositive()! ? "+" : "-") + percentage!.abs().toStringAsFixed(2) + "%";
    } else {
      return "";
    }
  }
}
