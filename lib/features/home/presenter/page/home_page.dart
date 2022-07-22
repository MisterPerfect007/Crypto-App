import 'package:crypto_trends/features/home/presenter/page/widgets/top_market.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../coinList/domain/entities/coin.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBanner(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: sidePadding,
                              ),
                              child: Builder(
                                builder: (BuildContext context) {
                                  return Column(children: [
                                    Row(children: [
                                      CoinCart(
                                          sidePadding: sidePadding, size: size),
                                      SizedBox(
                                        width: sidePadding,
                                      ),
                                      CoinCart(
                                          sidePadding: sidePadding, size: size),
                                    ]),
                                    Row(children: [
                                      CoinCart(
                                          sidePadding: sidePadding, size: size),
                                      // SizedBox(width: sidePadding,),
                                      // CoinCart(sidePadding: sidePadding, size: size),
                                    ])
                                  ]);
                                },
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: sidePadding),
                              child: Text(
                                "Top 10 Coins",
                                style: GoogleFonts.inter(
                                    color: AppColors.mainBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: sidePadding,
                              ),
                              child: Builder(
                                builder: (BuildContext context) {
                                  return Column(children: [
                                    Row(children: [
                                      CoinCart(
                                          sidePadding: sidePadding, size: size),
                                      SizedBox(
                                        width: sidePadding,
                                      ),
                                      CoinCart(
                                          sidePadding: sidePadding, size: size),
                                    ]),
                                    Row(children: [
                                      CoinCart(
                                          sidePadding: sidePadding, size: size),
                                      // SizedBox(width: sidePadding,),
                                      // CoinCart(sidePadding: sidePadding, size: size),
                                    ])
                                  ]);
                                },
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
      margin: const EdgeInsets.only(bottom: 15),
      width: (size.width / 2) - sidePadding * 1.5,
      decoration: const BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 1,
                color: AppColors.secondGrey),
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
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "\$29,298,389,379,328.90",
                style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.mainGreen.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: const PersoIcon(
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

List<Coin> dummyData = [
  Coin(id: "id", symbol: "symbol", name: "Bitcoin", currentPrice: 23977.89),
  Coin(id: "id", symbol: "symbol", name: "Bitcoin", currentPrice: 23977.89),
  Coin(id: "id", symbol: "symbol", name: "Bitcoin", currentPrice: 23977.89),
];
