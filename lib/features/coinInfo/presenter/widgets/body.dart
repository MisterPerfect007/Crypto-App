import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../bloc/coinChartInfo/coininfo_bloc.dart';
import '../cubit/time_slot_cubit.dart';
import 'coinChart/coin_chart.dart';
import 'coinNameImage/coin_name_image.dart';
import 'extraInfo/extra_infos.dart';
import 'priceAndPercentage/price_and_percentage.dart';
import 'timeSlots/time_slots_parent.dart';
import 'package:crypto_trends/injection_container.dart' as di;

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.coin,
  }) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    Size size = MediaQuery.of(context).size;
    return CustomOpacityAnimation(
      child: Container(
        height: size.height,
        color: theme.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: SafeArea(
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
                const SizedBox(height: 30),
                //
                //Chart
                MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => di.sl<CoinInfoBloc>()),
                    BlocProvider(create: (context) => TimeSlotCubit()),
                  ],
                  child: Column(
                    children: [
                      CoinChart(id: coin.id),
                      TimeSlotsParent(id: coin.id),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                ExtraInfos(coin: coin),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
