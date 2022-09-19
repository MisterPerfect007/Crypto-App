import 'package:crypto_trends/features/search/presenter/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../ui/colors/colors.dart';

class SeeAllPageAppBar extends StatelessWidget {
  const SeeAllPageAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    return SafeArea(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 0, right: sidePadding),
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
            const GoBack(),
            Container(
              margin: const EdgeInsets.only(left: 10),
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
