
import 'package:flutter/material.dart';

import '../../../../../ui/colors/colors.dart';

class CoinName extends StatelessWidget {
  final String symbol;
  final String name;
  final int? marketCapRank;
  const CoinName({
    Key? key, required this.symbol, required this.name, this.marketCapRank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
              color: AppColors.pureBlack,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        const SizedBox(height: 3,),
        Row(
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(3))),
              child: Text(
                marketCapRank != null ? marketCapRank.toString() : '?',
                style: const TextStyle(
                  color: AppColors.grey1,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            
            //Symbol
            Text(
              symbol.toUpperCase(),
              style: const TextStyle(
                color: AppColors.grey1,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            )
          ],
        )
      ],
    );
  }
}
