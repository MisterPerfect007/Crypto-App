import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/icons.dart';
import '../../../coinInfo/presenter/widgets/custom_ink_well_icon.dart';

class SeeAllPageAppBar extends StatelessWidget {
  const SeeAllPageAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.lightBg,
          boxShadow: [
            BoxShadow(
                color: AppColors.mainGrey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 1,
                spreadRadius: 0.2)
          ],
        ),
        child: Row(
          children: [
            CustomInkWellIcon(
              onTap: () {
                Navigator.pop(context);
              },
              size: 47,
              radius: 47,
              child: const PersoIcon(
                icon: PersoIcons.arrowLeft,
                color: AppColors.mainBlack,
                size: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
