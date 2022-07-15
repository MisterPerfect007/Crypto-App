import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/errors/failed_request.dart';
import '../../../../ui/colors/colors.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../bloc/coininfo_bloc.dart';
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
                      CoinChart(id: coin.id,),
                      const TimeSlotsParent(),
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

class CoinChart extends StatelessWidget {
  const CoinChart({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    context.read<CoinInfoBloc>().add(GetCoinInfo(
          id: id,
          currency: "usd",
          days: "1",
          dailyInterval: false,
        ));
    return SizedBox(
      height: 200,
      child: BlocBuilder<CoinInfoBloc, CoinInfoState>(
        builder: (context, state) {
          //*
          if (state is CoinInfoLoading) {
            return Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 241, 241, 241),
                highlightColor: const Color.fromARGB(255, 255, 255, 255),
                child: Container(
                  color: const Color.fromARGB(255, 241, 241, 241),
                ),
              ),
            );
          } else if (state is CoinInfoLoaded) {
            if(state.coinMarketChart.prices.length > 1){
              return CoinInfoLineChart(
                chartData:
                    CoinInfoLineChartData(coinMarketChart: state.coinMarketChart),
              );
            }else{
              //!
              //!
              //!
              //! 15 juil. 
              //!
              //!
              //!
              //!
            }
            print(state.coinMarketChart.prices);
            //*
          } else if (state is CoinInfoFailure) {
            //*
            if (state.errorType == ErrorType.noInternetConnection) {
              return Container(
                color: const Color.fromARGB(255, 241, 241, 241),
                child: FailedRequest(
                  small: true,
                  buttonOnPressed: () {},
                  buttonText: "Refresh",
                  icon: PersoIcons.coloredNoWifi,
                  title: "You're currently offline",
                  secondTitle:
                      "Check your internet connection and try to refresh.",
                ),
              );
            }
          }
          return Container(
            color: const Color.fromARGB(255, 241, 241, 241),
            child: FailedRequest(
              small: true,
              buttonOnPressed: () {},
              buttonText: "Try again",
              icon: PersoIcons.coloredRemove,
              title: "Something went wrong",
              secondTitle:
                  "Something went wrong on the back side, please try again.",
            ),
          );
        },
      ),
    );
  }
}
