import 'package:crypto_trends/features/coinInfo/presenter/widgets/timeSlots/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/time_slot_cubit.dart';

List<String> timeSlotList = ["1D", "7D", "1M", "3M", "1Y", "ALL"];

class TimeSlotsParent extends StatelessWidget {
  const TimeSlotsParent({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => TimeSlotCubit(),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: size.width,
        height: 50,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(
              androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
          child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              scrollDirection: Axis.horizontal,
              itemCount: timeSlotList.length,
              itemBuilder: ((context, index) {
                return TimeSlot(slot: timeSlotList[index], id: id,);
              })),
        ),
        // ),
      ),
    );
  }
}
