import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/coinChartInfo/coininfo_bloc.dart';
import '../cubit/time_slot_cubit.dart';

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
    {required BuildContext context, required String id, String? days}) {
  final daysForCall = days ?? context.read<TimeSlotCubit>().state;
  context.read<CoinInfoBloc>().add(GetCoinInfo(
        id: id,
        days: timeSlotToDaysNumber(daysForCall),
        dailyInterval: false,
      ));
}
