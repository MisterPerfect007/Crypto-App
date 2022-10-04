import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/coininfo/coininfo_bloc.dart';

const List<String> timeSlotList = ["24H", "7D", "1M", "3M", "1Y", "ALL"];
const List<String> timeSlotDaysList = ["1", "7", "30", "90", "365", "max"];

String timeSlotToDaysNumber(String timeSlot) {
  for (int i = 0; i < timeSlotList.length; i++) {
    if (timeSlotList[i] == timeSlot) {
      return timeSlotDaysList[i];
    }
  }
  return "1";
}

void triggerGetCoinInfo(
    {required BuildContext context, required String id, required String days}) {
  context.read<CoinInfoBloc>().add(GetCoinInfo(
        id: id,
        days: days,
        dailyInterval: false,
      ));
}
