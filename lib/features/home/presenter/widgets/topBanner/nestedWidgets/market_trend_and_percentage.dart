
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../core/coinPercentage/coin_percentage_format.dart';
import '../../../../../../../ui/colors/colors.dart';
import '../../../../../../../ui/icons/icons.dart';
import '../utils/market_trend.dart';

class MarketTrendLoaded extends StatelessWidget {
  const MarketTrendLoaded({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    CoinPercentageFormat fPercentage = CoinPercentageFormat(percentage: percentage);
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "Market is "),
              TextSpan(
                  text: getMarketTrendAsString(percentage))
            ]),
            style: GoogleFonts.inter(
                color: AppColors.mainWhite.withOpacity(0.8),
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 115),
            padding: const EdgeInsets.only(
                top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
                color: AppColors.mainWhite.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Row(children: [
              PersoIcon(
                icon: fPercentage.isPositive()!
                    ? PersoIcons.arrowUp
                    : PersoIcons.arrowDown,
                size: 12,
                color: fPercentage.getColor(),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Center(
                  child: Text(
                    fPercentage.fixedPercentage() + '%',
                    style: GoogleFonts.inter(
                        color: fPercentage.getColor(),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
