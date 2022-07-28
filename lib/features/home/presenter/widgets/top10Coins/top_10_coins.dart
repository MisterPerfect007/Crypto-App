import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import 'top_10_coin_cart.dart';

class Top10Coins extends StatelessWidget {
  const Top10Coins({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    return Container(
      padding: const EdgeInsets.only(top: 20),
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
                      Top10CoinCart(isLoading: true,),
                      SizedBox(
                        width: sidePadding,
                      ),
                      Top10CoinCart(),
                    ]),
                    Row(children: [
                      Top10CoinCart(),
                    ])
                  ]);
                },
              ),
            ),
          ]),
    );
  }
}