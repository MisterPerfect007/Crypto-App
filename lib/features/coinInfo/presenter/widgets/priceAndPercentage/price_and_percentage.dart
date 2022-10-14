import 'package:flutter/material.dart';

import '../../../../../core/coinPercentage/coin_percentage_format.dart';
import '../../../../../core/utils/price_formater.dart';
import '../../../../../ui/icons/icons.dart';
import '../../../../settings/utils/get_currency.dart';

// ignore: must_be_immutable
class PriceAndPercentage extends StatelessWidget {
  final double? percentage24h;
  final double? price;
  final double? priceChange24h;
  late CoinPercentageFormat formatedPercentage;
  PriceAndPercentage(
      {Key? key, required this.percentage24h, this.price, this.priceChange24h})
      : super(key: key) {
    formatedPercentage = CoinPercentageFormat(percentage: percentage24h);
  }

  @override
  Widget build(BuildContext context) {
    //currency
    final currency = CurrencyStorage().getCurrentCurrency();

    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              //Price
              Expanded(
                child: Text(
                  currency.symbol + " " + formatWithSmallPrice(price),
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              //percentage
              percentage24h != null
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: formatedPercentage.getColor().withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(children: [
                        formatedPercentage.isPositive() != null
                            ? PersoIcon(
                                icon: formatedPercentage.isPositive()!
                                    ? PersoIcons.arrowUp
                                    : PersoIcons.arrowDown,
                                size: 10,
                                color: formatedPercentage.getColor(),
                              )
                            : Container(),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          formatedPercentage.fixedPercentage() + "%",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: formatedPercentage.getColor(),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )
                      ]))
                  : Container()
            ],
          ),
          const SizedBox(height: 5),
          (percentage24h != null && priceChange24h != null)
              ? Text(
                  (formatedPercentage.isPositive()! ? "+" : "-") +
                      currency.symbol +
                      " " +
                      formatWithSmallPrice(priceChange24h!.abs()),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: formatedPercentage.getColor()),
                )
              : Container()
        ],
      ),
    );
  }
}
