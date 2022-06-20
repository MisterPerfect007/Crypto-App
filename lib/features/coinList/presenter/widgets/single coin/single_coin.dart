import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import 'coin_name.dart';
import 'coin_price.dart';
import 'single_coin_line_chart.dart';

class SingleCoin extends StatefulWidget {
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
        // decoration: const BoxDecoration(
        //     border: Border(
        //         bottom: BorderSide(
        //   color: AppColors.secondGrey,
        // ))),
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
                child: widget.lastWeekData != null
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
              currentPrice: widget.currentPrice,
              formated7DPercentage: widget.priceChangePercentage7dInCurrency ==
                      null
                  ? null
                  : CoinPercentageFormat(
                      percentage: widget.priceChangePercentage7dInCurrency!),
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

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  final String? image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: kTransparentImage,
        image: image!,
        width: 40,
        fit: BoxFit.fitWidth,
        imageErrorBuilder: (context, error, stackTrace) {
          return Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: AppColors.secondGrey,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Text(
              name[0],
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainWhite),
            ),
          );
        });
  }
}
