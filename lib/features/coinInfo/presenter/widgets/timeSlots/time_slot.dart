import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';

class TimeSlot extends StatelessWidget {
  const TimeSlot({Key? key, required this.isSelected}) : super(key: key);
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelected ? AppColors.mainGreen.withOpacity(0.1) : AppColors.mainWhite,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          boxShadow: isSelected
              ? null
              : [
                  const BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 1,
                      color: AppColors.secondGrey)
                ]),
      child: Text(
        "ALL",
        style: GoogleFonts.inter(
          color: isSelected ? AppColors.mainGreen : AppColors.mainGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
