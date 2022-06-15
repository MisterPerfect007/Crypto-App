import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';

class SingleCriteria extends StatelessWidget {
  const SingleCriteria({
    Key? key,
    required this.name,
    required this.isSelected,
  }) : super(key: key);
  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          color: isSelected? AppColors.mainGreen.withOpacity(0.1) : AppColors.mainWhite,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: isSelected? null : [
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
          onTap: () {},
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 7,
              bottom: 7,
            ),
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isSelected? AppColors.mainGreen : AppColors.mainGrey,
                // fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
