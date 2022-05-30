import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../ui/icons/icons.dart';

class CoinPrice extends StatelessWidget {
  final double? currentPrice;
  final CoinPercentageFormat? formated7DPercentage;
  CoinPrice({
    Key? key,
    required this.currentPrice,
    this.formated7DPercentage,
  }) : super(key: key);

  final numberFormater = NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 90),
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //* Current price
          Text(
            '\$ ' + priceFormater(1899993.0555),
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

  ///Custom method to format price for a correct display
  String priceFormater(double? price) {
    if (price == null) {
      return '??';
    } else {
      if (price < 1000000) {
        if (price < 100000) {
          return numberFormater.format(price);
        } else {
          return NumberFormat("#,###", "en_US").format(price);
        }
      } else {
        return NumberFormat.compact().format(price);
      }
    }
  }
}
