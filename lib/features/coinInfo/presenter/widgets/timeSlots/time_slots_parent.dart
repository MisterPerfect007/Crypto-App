import 'package:crypto_trends/features/coinInfo/presenter/widgets/timeSlots/time_slot.dart';
import 'package:flutter/material.dart';

class TimeSlotsParent extends StatelessWidget {
  const TimeSlotsParent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> timeSlotList = ["1D", "7D", "1M", "3M", "1Y", "ALL"];
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: size.width,
      height: 50,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        child: 
        // SingleChildScrollView(
        //   padding: const EdgeInsets.only(
        //       left: 10, top: 10, right: 10, bottom: 10),
        //   scrollDirection: Axis.horizontal,
        //   child: 
          ListView.builder(
            padding: const EdgeInsets.only(
              left: 10, top: 10, right: 10, bottom: 10),
            scrollDirection: Axis.horizontal,
            itemCount: timeSlotList.length,
            itemBuilder: ((context, index) {
              return TimeSlot(isSelected: false, slot: timeSlotList[index]);
            })
          ),
          // Row(children: const [
          //   TimeSlot(isSelected: true, slot: '1D',),
          //   SizedBox(
          //     width: 20,
          //   ),
          //   TimeSlot(isSelected: false, slot: '1W',),
          //   SizedBox(
          //     width: 20,
          //   ),
          // ]),
        ),
      // ),
    );
  }
}