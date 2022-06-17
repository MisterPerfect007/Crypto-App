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

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //* Current price
          AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                child: child,
                position: Tween<Offset>(
                        begin: Offset(0.0, -5), end: Offset(0.0, 0.0))
                    .animate(animation),
              );
            },
            child: Text(
              '\$ ' + priceFormater(currentPrice),
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: AppColors.pureBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
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
                  formated7DPercentage!.fixedPercentage() + '%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: formated7DPercentage!.getColor,
                        fontWeight: FontWeight.w500,
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

  final numberFormater = NumberFormat("#,###.00", "en_US");

  ///Custom method to format price for a correct display
  static String priceFormater(double? price) {
    if (price == null) {
      return '??';
    } else {
      if (price < 1000000) {
        if (price < 1) {
          if (price < 0.01) {
            return NumberFormat("#.${'#' * 8}", "en_US").format(price);
          } else {
            return NumberFormat("#.${'#' * 4}", "en_US").format(price);
          }
        } else {
          return NumberFormat("#,###.00", "en_US").format(price);
        }
      } else {
        return NumberFormat.compact().format(price);
      }
    }
  }
}
