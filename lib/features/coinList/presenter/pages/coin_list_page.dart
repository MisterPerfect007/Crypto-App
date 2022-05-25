import 'dart:ui';

import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.red, width: 5),
        // ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SortingCriteria(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: const [
                    SingleCoin(
                      name: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                      symbol: '',
                    ),
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}
