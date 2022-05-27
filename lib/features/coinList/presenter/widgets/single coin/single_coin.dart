import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/features/coinList/presenter/pages/sample_data.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:flutter/material.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import 'coin_name.dart';
import 'coin_price.dart';
import 'single_coin_line_chart.dart';

class SingleCoin extends StatelessWidget {
  final String name;
  final String? image;
  final String symbol;
  final double? currentPrice;
  final int? marketCapRank;
  final double? priceChangePercentage7dInCurrency;
  final List<double>? lastWeekData;
  const SingleCoin({
    Key? key,
    required this.name,
    this.image,
    required this.symbol,
    this.currentPrice,
    this.marketCapRank,
    this.priceChangePercentage7dInCurrency,
    this.lastWeekData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      padding: EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
        bottom: 10,
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: AppColors.secondGrey,
      ))),
      child: Row(
        children: [
          Image.network(
            image!,
            width: 40,
          ),
          const SizedBox(
            width: 5,
          ),
          //Name and Rank
          //
          CoinName(
            name: name,
            symbol: symbol,
            marketCapRank: marketCapRank,
          ),
          //Chart
          //
          Expanded(
            child: Align(
              child: Container(
                height: 40,
                constraints:
                    const BoxConstraints(minWidth: 100, maxWidth: 300),
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: const SingleCoinLineChart(
                  chartData: CoinLineChartData(dataList: weekData),
                ),
              ),
            ),
          ),
          //Price and week evolution
          //
          CoinPrice(
            currentPrice: currentPrice,
            formated7DPercentage: priceChangePercentage7dInCurrency == null
                ? null
                : CoinPercentageFormat(
                    percentage: priceChangePercentage7dInCurrency!),
          ),
          const SizedBox(
            width: 5,
          ),
          //Favorite
          //
          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const PersoIcon(
                icon: PersoIcons.starOutline,
                color: AppColors.mainGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
