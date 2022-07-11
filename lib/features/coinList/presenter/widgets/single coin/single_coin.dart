import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/widgets/custom_network_image.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import 'coin_name.dart';
import 'coin_price.dart';
import 'single_coin_line_chart.dart';

class SingleCoin extends StatefulWidget {
  final String name;
  final String id;
  final String? image;
  final String symbol;
  final double? currentPrice;
  final int? marketCapRank;
  final double? priceChangePercentage7dInCurrency;
  final List<double>? lastWeekData;
  final bool? isUpdate;
  const SingleCoin({
    Key? key,
    required this.name,
    this.image,
    required this.symbol,
    this.currentPrice,
    this.marketCapRank,
    this.priceChangePercentage7dInCurrency,
    this.lastWeekData,
    required this.id, this.isUpdate,
  }) : super(key: key);

  @override
  State<SingleCoin> createState() => _SingleCoinState();
}

class _SingleCoinState extends State<SingleCoin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
          left: sidePadding,
          right: sidePadding,
          bottom: 10,
        ),
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Row(
          children: [
            CustomNetworkImage(
              image: widget.image,
              name: widget.name,
            ),
            const SizedBox(
              width: 5,
            ),
            //Name and Rank
            //
            CoinName(
              name: widget.name,
              symbol: widget.symbol,
              marketCapRank: widget.marketCapRank,
            ),
            //Chart
            //
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: widget.lastWeekData!.isNotEmpty
                    ? Container(
                        height: 20,
                        // constraints:
                        //     const BoxConstraints(minWidth: 200, maxWidth: 300),
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: SingleCoinLineChart(
                          chartData:
                              CoinLineChartData(dataList: widget.lastWeekData!),
                        ),
                      )
                    : Container(),
              ),
            ),
            //Price and week evolution
            //
            CoinPrice(
              id: widget.id,
              currentPrice: widget.currentPrice,
              formated7DPercentage: widget.priceChangePercentage7dInCurrency != null
                  ? CoinPercentageFormat(
                      percentage: widget.priceChangePercentage7dInCurrency!)
                  : null,
                      // percentage: calculate7DPercentage(widget.lastWeekData)!),
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
      ),
    );
  }
}
