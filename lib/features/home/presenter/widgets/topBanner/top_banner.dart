import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../ui/colors/colors.dart';
import 'nestedWidgets/market_trend_loaded.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      // height: 200,
      width: size.width,
      padding: EdgeInsets.only(
          left: sidePadding, right: sidePadding, top: 10, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.thirdGrey.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 2)),
        ],
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            AppColors.mainGreen,
            Color.fromARGB(255, 0, 251, 121),
          ],
        ),
      ),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crypto Trend",
                style: GoogleFonts.inter(
                    color: AppColors.mainWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ],
          ),
          const SizedBox(height: 20),
          const MarketTrendAndPercentage()
        ],
      )),
    );
  }
}
