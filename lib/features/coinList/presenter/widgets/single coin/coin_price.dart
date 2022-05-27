import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../ui/icons/icons.dart';

class CoinPrice extends StatelessWidget {
  final double? currentPrice;
  final CoinPercentageFormat? formated7DPercentage;
  const CoinPrice({
    Key? key,
    required this.currentPrice,
    this.formated7DPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormater = NumberFormat("#,##0.00", "en_US");

    return Container(
      constraints: const BoxConstraints(maxWidth: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //* Current price
          Text(
            '\$' +
                (currentPrice != null
                    ? numberFormater.format(currentPrice)
                    : '??'),
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  color: AppColors.mainBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: 13),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          //* Percentage
          if (formated7DPercentage != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PersoIcon(
                  icon: formated7DPercentage!.isPositive
                      ? PersoIcons.arrowUp
                      : PersoIcons.arrowDown,
                  size: 9,
                  color: formated7DPercentage!.getColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  formated7DPercentage!.signedPercentage() + '%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: formated7DPercentage!.getColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 11),
                  ),
                )
              ],
            )
          else
            Container(),
        ],
      ),
    );
  }
}
