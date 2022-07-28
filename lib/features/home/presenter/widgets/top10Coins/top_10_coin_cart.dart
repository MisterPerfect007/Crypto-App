import 'package:crypto_trends/core/widgets/coin_image_shimmer.dart';
import 'package:crypto_trends/core/widgets/custom_container_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/custom_network_image.dart';
import '../../../../../ui/colors/colors.dart';

class Top10CoinCart extends StatelessWidget {
  const Top10CoinCart({
    Key? key,
    this.isLoading,
  }) : super(key: key);

  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    bool showLoading = isLoading ?? false;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: (size.width / 2) - sidePadding * 1.5,
      decoration: const BoxDecoration(
          color: AppColors.mainWhite,
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
                    "1",
                    style: GoogleFonts.inter(
                        color: AppColors.mainBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  )),
            Expanded(child: Container()),
            if (showLoading)
              const CoinImageShimmer(width: 30)
            else
              const CustomNetworkImage(
                image:
                    'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                name: 'Bitcoin',
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
            "Bitcoin",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.mainBlack,
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
                      "\$29,298.90",
                      style: GoogleFonts.inter(
                          color: AppColors.mainBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            showLoading
                ? const ContainerShimmer(width: 20, height: 20, radius: 15)
                : Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColors.mainGreen.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: SvgPicture.asset("assets/svg/chart-line-up.svg",
                        width: 10, color: AppColors.mainGreen),
                  )
          ],
        ),
        if (showLoading)
          const ContainerShimmer(width: 30, height: 12, radius: 5)
        else
          Text(
            "+8.9%",
            style: GoogleFonts.inter(
                color: AppColors.mainGreen,
                fontWeight: FontWeight.w500,
                fontSize: 11),
          ),
      ]),
    );
  }
}
