import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';

class CoinName extends StatelessWidget {
  final String symbol;
  final String name;
  final int? marketCapRank;
  const CoinName({
    Key? key,
    required this.symbol,
    required this.name,
    this.marketCapRank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 80, minWidth: 80),
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.length > 8 ? "${name.substring(0, 8)}..": name,
            style: GoogleFonts.inter(
                color: AppColors.pureBlack,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          const SizedBox(
            height: 3,
          ),
          Wrap(
            children: [
              //MarketCapRank
              Container(
                padding: const EdgeInsets.only(
                  top: 0,
                  right: 3,
                  bottom: 0,
                  left: 3,
                ),
                decoration: const BoxDecoration(
                    color: AppColors.thirdGrey,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Text(
                  marketCapRank != null ? marketCapRank.toString() : '?',
                  style: GoogleFonts.inter(
                    color: AppColors.grey1,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),

              //Symbol
              Text(
                symbol.toUpperCase(),
                style: GoogleFonts.inter(
                  color: AppColors.mainGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
