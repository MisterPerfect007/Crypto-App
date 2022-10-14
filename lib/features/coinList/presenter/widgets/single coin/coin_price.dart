import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/features/settings/utils/get_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../ui/icons/icons.dart';

class CoinPrice extends StatelessWidget {
  final String id;
  final double? currentPrice;
  final CoinPercentageFormat? formated7DPercentage;
  final bool? isUpdate;

  const CoinPrice({
    Key? key,
    required this.currentPrice,
    this.formated7DPercentage,
    required this.id,
    this.isUpdate = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);

    //currency
    final currency = CurrencyStorage().getCurrentCurrency();

    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //* Current price
          Text(
            currency.symbol + " " + priceFormater(currentPrice),
            style: TextStyle(
              fontFamily: 'Inter',
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
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
                  icon: formated7DPercentage!.isPositive()!
                      ? PersoIcons.arrowUp
                      : PersoIcons.arrowDown,
                  size: 9,
                  color: formated7DPercentage!.getColor(),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  formated7DPercentage!.fixedPercentage() + '%',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: formated7DPercentage!.getColor(),
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
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
          return NumberFormat("#,###.##", "en_US").format(price);
        }
      } else {
        return NumberFormat.compact().format(price);
      }
    }
  }
}
