import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/coin_line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/widgets/custom_network_image.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import 'coin_name.dart';
import 'coin_price.dart';
import 'single_coin_line_chart.dart';

class SingleCoin extends StatefulWidget {
  final Coin coin;
  const SingleCoin({
    Key? key,
    required this.coin
  }) : super(key: key);

  @override
  State<SingleCoin> createState() => _SingleCoinState();
}

class _SingleCoinState extends State<SingleCoin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    final coin = widget.coin;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoinInfoPage(coin: coin)),
        );
      },
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
              image: coin.image,
              name: coin.name,
            ),
            const SizedBox(
              width: 5,
            ),
            //Name and Rank
            //
            CoinName(
              name: coin.name,
              symbol: coin.symbol,
              marketCapRank: coin.marketCapRank,
            ),
            //Chart
            //
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: coin.sparklineIn7d!.price.isNotEmpty
                    ? Container(
                        height: 20,
                        constraints:
                            const BoxConstraints(minWidth: 70, maxWidth: 300),
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: SingleCoinLineChart(
                          chartData:
                              CoinLineChartData(dataList: coin.sparklineIn7d!.price),
                        ),
                      )
                    : Container(),
              ),
            ),
            //Price and week evolution
            //
            CoinPrice(
              id: coin.id,
              currentPrice: coin.currentPrice,
              formated7DPercentage:
                  coin.priceChangePercentage7dInCurrency != null
                      ? CoinPercentageFormat(
                          percentage: coin.priceChangePercentage7dInCurrency!)
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
