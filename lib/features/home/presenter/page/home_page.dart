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
            child: Column(children: [
          TopBanner(),
          Column(children: [
            Text("Trending Coins"),
            Container(
              child: Column(
                children: [
                  CustomNetworkImage(
                    image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579', 
                    name: 'Bitcoin',),
                  Text("Bitcoin",
                  style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  )
                ]
              ),
            )
          ])
        ])),
      ),
    );
  }
}
