import 'package:flutter/material.dart';

import '../widgets/top10Coins/top_10_coins.dart';
import '../widgets/topBanner/top_banner.dart';
import '../widgets/trendingCoins/trending_coins.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBanner(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        TrendingCoins(),
                        Top10Coins(),
                        SizedBox(height: 70),
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
