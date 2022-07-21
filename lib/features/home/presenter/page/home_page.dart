import 'package:crypto_trends/features/home/presenter/page/widgets/top_market.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_network_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: AppColors.lightBg,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBanner(),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: sidePadding),
                      child: Text(
                        "Trending Coins",
                        style: GoogleFonts.inter(
                            color: AppColors.mainBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.only(left: sidePadding, right: sidePadding, top: 10, bottom: 10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CoinCart(size: size, sidePadding: sidePadding),
                          SizedBox(width: 20,),
                          CoinCart(size: size, sidePadding: sidePadding),
                          SizedBox(width: 20,),
                          CoinCart(size: size, sidePadding: sidePadding),
                          SizedBox(width: 20,),
                          CoinCart(size: size, sidePadding: sidePadding),
                        ],
                      ),
                    )
                    
                  ]),
            )
          ],
        )),
      ),
    );
  }
}

class CoinCart extends StatelessWidget {
  const CoinCart({
    Key? key,
    required this.size,
    required this.sidePadding,
  }) : super(key: key);

  final Size size;
  final double sidePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: (size.width / 2) - (sidePadding * 3),
      decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.thirdGrey.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: AppColors.thirdGrey.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 2,
            )
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CustomNetworkImage(
          image:
              'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
          name: 'Bitcoin',
          width: 30,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Bitcoin",
          style: GoogleFonts.inter(
              color: AppColors.mainBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        // const SizedBox(height: 5,),
        Row(
          children: [
            Text(
              "\$29,298.90",
              style: GoogleFonts.inter(
                  color: AppColors.mainBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.mainGreen.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: PersoIcon(
                icon: PersoIcons.arrowUp,
                size: 12,
              ),
            )
          ],
        ),
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
