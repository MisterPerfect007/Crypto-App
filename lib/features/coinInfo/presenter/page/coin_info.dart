import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../../ui/colors/colors.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../utils/coin_info_line_chart_data.dart';
import '../utils/large_sample_data.dart';
import '../widgets/coinChart/coin_line_chart.dart';
import '../widgets/coinNameImage/coin_name_image.dart';
import '../widgets/coin_info_app_bar.dart';
import '../widgets/extraInfo/extra_infos.dart';
import '../widgets/priceAndPercentage/price_and_percentage.dart';
import '../widgets/timeSlots/time_slots_parent.dart';

class CoinInfoPage extends StatelessWidget {
  const CoinInfoPage({Key? key, required this.coin}) : super(key: key);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(coin);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          60,
        ),
        child: const CustomOpacityAnimation(child: CoinInfoPageAppBar()),
      ),
      body: CustomOpacityAnimation(
              child: Container(
                height: size.height,
                color: AppColors.lightBg,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(
                      androidOverscrollIndicator:
                          AndroidOverscrollIndicator.stretch),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        CoinNameImage(
                          image: coin.image,
                          name: coin.name,
                        ),
                        PriceAndPercentage(
                          price: coin.currentPrice,
                          percentage24h: coin.priceChangePercentage24h,
                          priceChange24h: coin.priceChange24h,
                        ),
                        const SizedBox(height: 50),
                        const CoinChart(),
                        const TimeSlotsParent(),
                        const SizedBox(height: 30),
                        ExtraInfos(coin: coin),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
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
