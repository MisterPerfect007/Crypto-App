import 'package:flutter/material.dart';

import '../../../../../core/utils/price_formater.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../../../settings/utils/get_currency.dart';
import 'extra_info.dart';

class ExtraInfos extends StatelessWidget {
  const ExtraInfos({
    Key? key,
    required this.coin
  }) : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    //currency
    final currency = CurrencyStorage().getCurrentCurrency();
    
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
        padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
        width: size.width,
        child: Column(
          children: [
            ExtraInfo(
              infoName: "Rank",
              value: (coin.marketCapRank ?? "??").toString(),
            ),
            ExtraInfo(
              infoName: "Symbol",
              value: coin.symbol.toUpperCase(),
            ),
            ExtraInfo(
              infoName: "High 24h",
              value: currency.symbol + " " + formatWithSmallPrice(coin.high24h),
            ),
            ExtraInfo(
              infoName: "Low 24h",
              value: currency.symbol + " " + formatWithSmallPrice(coin.low24h),
            ),
            ExtraInfo(
              infoName: "Vol.",
              value: currency.symbol + " " + formatWithSmallPrice(coin.totalVolume),
            ),
            ExtraInfo(
              infoName: "Mkt. Cap.",
              value: currency.symbol + " " + formatWithSmallPrice(coin.marketCap),
            ),
          ],
        ));
  }
}
