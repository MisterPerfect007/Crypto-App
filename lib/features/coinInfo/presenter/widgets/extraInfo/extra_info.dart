
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';

class ExtraInfo extends StatelessWidget {
  final String? value;
  final String infoName;
  const ExtraInfo({
    Key? key,
    required this.infoName,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(
            infoName,
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.mainGrey),
          ),
          // Expanded(child: Container()),
          Text(
            value!.toString(),
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.mainBlack),
          )
        ],
      ),
    );
  }
}