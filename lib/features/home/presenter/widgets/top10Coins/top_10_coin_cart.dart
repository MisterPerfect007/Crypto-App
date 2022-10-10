import 'package:crypto_trends/core/widgets/coin_image_shimmer.dart';
import 'package:crypto_trends/core/widgets/custom_container_shimmer.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/coinPercentage/coin_percentage_format.dart';
import '../../../../../core/utils/price_formater.dart';
import '../../../../../core/widgets/custom_network_image.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/svg_icons.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../../../settings/utils/get_currency.dart';

class Top10CoinCart extends StatelessWidget {
  const Top10CoinCart({
    Key? key,
    this.isLoading,
    this.action,
    this.coin,
  }) : super(key: key);

  final bool? isLoading;
  final void Function()? action;
  final Coin? coin;

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    bool showLoading = isLoading ?? coin == null;

    CoinPercentageFormat percentage =
        CoinPercentageFormat(percentage: coin?.priceChangePercentage24h);

    //currency
    final currency = CurrencyStorage().getCurrentCurrency();

    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: (size.width / 2) - sidePadding * 1.5,
        decoration: const BoxDecoration(
          // color: AppColors.mainWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              if (showLoading)
                const ContainerShimmer(width: 15, height: 20, radius: 5)
              else
                Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 2, bottom: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.secondGrey,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      "${coin?.marketCapRank}",
                      style: GoogleFonts.inter(
                          color: AppColors.mainBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    )),
              Expanded(child: Container()),
              if (showLoading)
                const CoinImageShimmer(width: 30)
              else
                CustomNetworkImage(
                  image: coin?.image,
                  name: coin?.name ?? "",
                  width: 30,
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (showLoading)
            const ContainerShimmer(width: 50, height: 15, radius: 5)
          else
            Text(
              "${coin?.name}",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: showLoading
                    ? const ContainerShimmer(width: 50, height: 15, radius: 5)
                    : Text(
                        currency.symbol + " " + formatWithSmallPrice(coin?.currentPrice),
                        style: GoogleFonts.inter(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (showLoading)
                const ContainerShimmer(width: 20, height: 20, radius: 15)
              else if (coin?.priceChangePercentage24h != null)
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: percentage.getColor().withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: SvgIcon(
                      icon: percentage.isPositive()!
                          ? SvgIcons.chartLineUp
                          : SvgIcons.chartLineDown,
                      color: percentage.getColor(),
                      size: 10),
                )
            ],
          ),
          if (showLoading)
            const ContainerShimmer(width: 30, height: 12, radius: 5)
          else
            buildPercentage(percentage),
        ]),
      ),
    );
  }

  Widget buildPercentage(CoinPercentageFormat percentage) {
    return coin?.priceChangePercentage24h != null
        ? Text(
            percentage.signedPercentage(),
            style: GoogleFonts.inter(
                color: percentage.getColor(),
                fontWeight: FontWeight.w500,
                fontSize: 9),
          )
        : Container();
  }
}
