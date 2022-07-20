import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/coininfo_bloc.dart';

String customFormater(double? price) {
  if (price == null) {
    return "??";
  } else {
    if (price == 0.0) {
      return "0.0";
    }
    if (price > 10) {
      return NumberFormat("#,###.##", "en_US").format(price);
    } else if (price > 0.001) {
      return NumberFormat("#,###.${"#" * 6}", "en_US").format(price);
    } else if (price > 0.000000000000001) {
      return NumberFormat("#,###.${"#" * 15}", "en_US").format(price);
    }
    // print(Decimal.parse(price.toString()));
    return Decimal.parse(price.toString()).toString();
  }
}

const List<String> timeSlotList = ["24H", "7D", "1M", "3M", "1Y", "ALL"];
const List<String> timeSlotDaysList = ["1", "7", "30", "90", "365", "max"];

String timeSlotToDaysNumber(String timeSlot) {
  for (int i = 0; i < timeSlotList.length; i++) {
    if(timeSlotList[i] == timeSlot){
      return timeSlotDaysList[i];
    }
    
  }
  return "1";
}

void triggerGetCoinInfo({required BuildContext context, required String id, required String days}) {
  context.read<CoinInfoBloc>().add(GetCoinInfo(
        id: id,
        currency: "usd",
        days: days,
        dailyInterval: false,
      ));
}