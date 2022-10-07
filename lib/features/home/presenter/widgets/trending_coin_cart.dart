import 'package:crypto_trends/core/widgets/coin_image_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/coinPercentage/coin_percentage_format.dart';
import '../../../../core/utils/price_formater.dart';
import '../../../../core/widgets/custom_container_shimmer.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../ui/colors/colors.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../../coinList/presenter/utils/coin_line_chart_data.dart';
import '../../../coinList/presenter/widgets/single coin/single_coin_line_chart.dart';
import '../../../settings/utils/get_currency.dart';

class TrendingCoinCart extends StatelessWidget {
  final bool? isLoading;
  final Coin? coin;

  const TrendingCoinCart({Key? key, this.isLoading, this.coin, this.action})
      : super(key: key);

  final void Function()? action;

  @override
  Widget build(BuildContext context) {
    //currency
    final currency = CurrencyStorage().getCurrentCurrency();

    bool showLoading = isLoading ?? false;
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    CoinPercentageFormat percentage = CoinPercentageFormat(
        percentage: coin?.priceChangePercentage7dInCurrency);

    return InkWell(
      onTap: action,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        width: (size.width / 2) - sidePadding * 1.5,
        decoration: const BoxDecoration(
          color: AppColors.mainWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showLoading)
                  const CoinImageShimmer(width: 25)
                else
                  CustomNetworkImage(
                    image: coin?.image,
                    name: coin?.name ?? "",
                    width: 25,
                  ),
                if (showLoading)
                  const ContainerShimmer(width: 20, height: 8, radius: 5)
                else
                  coin?.priceChangePercentage7dInCurrency != null
                      ? Expanded(
                          child: Text(
                            // 7 days %
                            percentage.signedPercentage(),
                            textAlign: TextAlign.end,
                            style: GoogleFonts.inter(
                                color: percentage.getColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 9),
                          ),
                        )
                      : Container(),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (showLoading)
              const ContainerShimmer(width: 50, height: 8, radius: 5)
            else
              //Name
              Text(
                "${coin?.name}",
                style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            const SizedBox(
              height: 5,
            ),
            if (showLoading)
              const ContainerShimmer(width: 40, height: 8, radius: 5)
            else
              Text(
                currency.symbol +
                    " " +
                    formatWithSmallPrice(coin?.currentPrice),
                style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 9),
              ),
            const SizedBox(height: 10),
            if (showLoading)
              const ContainerShimmer(
                  width: double.infinity, height: 47, radius: 5)
            else if (coin!.sparklineIn7d != null)
              //! if sparklineIn7d doesn't exist
              SizedBox(
                  height: 40,
                  child: SingleCoinLineChart(
                    chartData:
                        CoinLineChartData(dataList: coin!.sparklineIn7d!.price),
                  ))
          ],
        ),
      ),
    );
  }
}
