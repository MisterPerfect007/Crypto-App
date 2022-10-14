import 'package:flutter/material.dart';

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
    //
    final theme = Theme.of(context);
    //
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      // height: 200,
      width: size.width,
      padding: EdgeInsets.only(
          left: sidePadding, right: sidePadding, top: 10, bottom: 20),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //       color: AppColors.thirdGrey.withOpacity(0.3),
        //       blurRadius: 2,
        //       spreadRadius: 2,
        //       offset: const Offset(0, 2)),
        // ],
        gradient:  LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: isDarkMode ? [
            theme.disabledColor,
            theme.disabledColor,
            // theme.primaryColor,
          ] : [
            AppColors.mainGreen,
            const Color.fromARGB(255, 0, 251, 121),
          ],
        ),
      ),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Crypto Trends 📈",
                style: TextStyle(
              fontFamily: 'Inter',
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
