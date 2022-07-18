import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:crypto_trends/features/coinInfo/presenter/cubit/time_slot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../../ui/colors/colors.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../bloc/coininfo_bloc.dart';
import '../widgets/coinChart/coin_chart.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          60,
        ),
        child: const CustomOpacityAnimation(child: CoinInfoPageAppBar()),
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => di.sl<CoinInfoBloc>()),
            BlocProvider(create: (context) => TimeSlotCubit()),
          ],
          child: CustomOpacityAnimation(
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
                      const SizedBox(height: 30),
                      CoinChart(
                        id: coin.id,
                      ),
                      TimeSlotsParent(id: coin.id,),
                      const SizedBox(height: 30),
                      ExtraInfos(coin: coin),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
