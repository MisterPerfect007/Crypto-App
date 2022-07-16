import 'package:crypto_trends/features/coinInfo/presenter/cubit/time_slot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../bloc/coininfo_bloc.dart';
import '../../utils/functions.dart';

class TimeSlot extends StatelessWidget {
  const TimeSlot({
    Key? key,
    required this.slot,
    required this.id,
  }) : super(key: key);
  final String slot;
  final String id;

  @override
  Widget build(BuildContext context) {
    bool isSelected;
    return BlocBuilder<TimeSlotCubit, String>(
      bloc: context.read<TimeSlotCubit>(),
      builder: (context, String state) {
        isSelected = (state == slot);
        return Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.mainGreen.withOpacity(0.1)
                  : AppColors.mainWhite,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: isSelected
                  ? null
                  : [
                      const BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 1,
                          color: AppColors.secondGrey),
                    ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              splashColor: AppColors.secondGreen,
              onTap: () {
                handleTimeSlotChange(context);
              },
              radius: 5,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text(
                  slot,
                  style: GoogleFonts.inter(
                    color:
                        isSelected ? AppColors.mainGreen : AppColors.mainGrey,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void handleTimeSlotChange(BuildContext context) {
    final oldState = context.read<TimeSlotCubit>().state;

    context.read<TimeSlotCubit>().changeTimeSlot(slot);

    final state = context.read<TimeSlotCubit>().state;

    if (state != oldState) {
      context.read<CoinInfoBloc>().add(GetCoinInfo(
            id: id,
            currency: "usd",
            days: timeSlotToDaysNumber(state),
            dailyInterval: false,
          ));
    }
  }
}
