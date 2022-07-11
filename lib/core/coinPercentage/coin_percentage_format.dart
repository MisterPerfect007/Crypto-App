import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';

class CoinPercentageFormat extends Equatable {
  final double? percentage;

  const CoinPercentageFormat({required this.percentage});

  @override
  List<Object?> get props => [percentage];

  bool isPositive (){
    if(percentage != null){
      return percentage! >= 0;
    }else {
      return false;
    }
  }

  Color get getColor => isPositive() ? AppColors.mainGreen : AppColors.pureRed;

  String fixedPercentage() {
    if(percentage != null){
      return percentage!.abs().toStringAsFixed(2);
    }else {
      return "";
    }
    
  }
}
