import 'package:flutter/material.dart';


import '../../../../ui/colors/colors.dart';
import '../utils/coin_info_line_chart_data.dart';
import '../utils/large_sample_data.dart';
import '../widgets/coinChart/coin_line_chart.dart';
import '../widgets/coinNameImage/coin_name_image.dart';
import '../widgets/coin_info_app_bar.dart';
import '../widgets/priceAndPercentage/price_and_percentage.dart';

class CoinInfoPage extends StatelessWidget {
  const CoinInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const CoinInfoPageAppBar(),
      ),
      body: Container(
        color: AppColors.lightBg,
        child: Column(
          children: [
            const CoinNameImage(),
            PriceAndPercentage(
              percentage: 99.0,
            ),
            const SizedBox(
              height: 50,
            ),
            const CoinChart(),
            Container(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.mainWhite,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: AppColors.secondGrey
                        )
                      ]
                    ),
                    child: Text("24h"),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CoinChart extends StatelessWidget {
  const CoinChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CoinInfoLineChart(
        chartData: CoinInfoLineChartData(coinMarketChart: largeCoinMarketChart),
      ),
    );
  }
}
