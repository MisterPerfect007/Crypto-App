
import 'package:crypto_trends/features/coinInfo/presenter/widgets/timeSlots/time_slot.dart';
import 'package:flutter/material.dart';

class TimeSlotsParent extends StatelessWidget {
  const TimeSlotsParent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: size.width,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
              left: 10, top: 10, right: 10, bottom: 10),
          scrollDirection: Axis.horizontal,
          child: Row(children: const [
            TimeSlot(isSelected: true,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
            SizedBox(
              width: 20,
            ),
            TimeSlot(isSelected: false,),
          ]),
        ),
      ),
    );
  }
}