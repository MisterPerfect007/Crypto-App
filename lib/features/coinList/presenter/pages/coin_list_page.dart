import 'package:crypto_trends/features/coinList/presenter/pages/sample_data.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/single coin/single_coin.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: CoinPageAppBar(size: size),
      ),
      body: Container(
        height: size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SortingCriteria(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: const [
                    SingleCoin(
                      name: 'Bitcoin',
                      image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                      symbol: 'btc',
                      currentPrice: 930984.99,
                      marketCapRank: 1,
                      priceChangePercentage7dInCurrency: 9.1287,
                      lastWeekData: weekData,
                    ),
                    SingleCoin(
                      name: 'Ethereum eth',
                      image: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880',
                      symbol: 'btc',
                      currentPrice: 1.82,
                      marketCapRank: 1,
                      priceChangePercentage7dInCurrency: 19.1287,
                      lastWeekData: weekData,
                    ),
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}
