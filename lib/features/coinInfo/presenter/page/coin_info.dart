import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/features/coinInfo/presenter/cubit/time_slot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../../ui/colors/colors.dart';
import '../../../coinList/domain/entities/coin.dart';

import '../bloc/coin_infos/coin_infos_bloc.dart';
import '../bloc/coininfo/coininfo_bloc.dart';
import '../widgets/coinChart/coin_chart.dart';
import '../widgets/coinNameImage/coin_name_image.dart';
import '../widgets/coin_info_app_bar.dart';
import '../widgets/extraInfo/extra_infos.dart';
import '../widgets/priceAndPercentage/price_and_percentage.dart';
import '../widgets/timeSlots/time_slots_parent.dart';


class CoinInfoPage extends StatelessWidget {
  const CoinInfoPage({Key? key, required this.coin, required this.id})
      : super(key: key);
  final Coin? coin;
  final String id;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => di.sl<CoinInfosBloc>(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            size.width,
            50,
          ),
          child: const CustomOpacityAnimation(child: CoinInfoPageAppBar()),
        ),
        body: coin != null
            ? Body(coin: coin!)
            : Builder(builder: (context) {
                handleApiCall(context);
                return BlocBuilder<CoinInfosBloc, CoinInfosState>(
                  builder: (context, state) {
                    if(state is CoinInfosInitial || state is CoinInfosLoading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if (state is CoinInfosLoaded){
                      return Body(coin: state.coin);
                    }
                    else if (state is CoinInfosFailure){
                      if(state.errorType == ErrorType.noInternetConnection){
                        return CustomOpacityAnimation(
                          child: Row(
                            children: [
                              
                            ],
                          ),
                        );
                      }
                    }
                    return Container();
                  },
                );
              }), /* if coin is null so make a call to the API */
      ),
    );
  }
  
  ///Should trigger the [CoinInfosGet] event if the state is not [CoinInfosLoaded]
  void handleApiCall(BuildContext context){
    if(context.read<CoinInfosBloc>().state is! CoinInfosLoaded){
      context.read<CoinInfosBloc>().add(CoinInfosGet(coinId: id, currency: 'usd'));
    }
  }
   
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.coin,
  }) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomOpacityAnimation(
      child: Container(
        height: size.height,
        color: AppColors.lightBg,
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
