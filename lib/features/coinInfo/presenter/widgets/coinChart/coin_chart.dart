import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../core/widgets/errors/failed_request.dart';
import '../../../../../errors/error_types.dart';
import '../../../../../ui/icons/icons.dart';
import '../../bloc/coininfo_bloc.dart';
import '../../cubit/time_slot_cubit.dart';
import '../../utils/coin_info_line_chart_data.dart';
import 'coin_line_chart.dart';

class CoinChart extends StatefulWidget {
  const CoinChart({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<CoinChart> createState() => _CoinChartState();
}

class _CoinChartState extends State<CoinChart> {
  @override
  void initState() {
    super.initState();
    context.read<CoinInfoBloc>().add(GetCoinInfo(
          id: widget.id,
          currency: "usd",
          days: "1",
          dailyInterval: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // context.read<CoinInfoBloc>().add(GetCoinInfo(
    //       id: id,
    //       currency: "usd",
    //       days: "1",
    //       dailyInterval: false,
    //     ));
    return CustomOpacityAnimation(
      duration: const Duration(seconds: 1),
      child: SizedBox(
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
              // print(state.coinMarketChart.prices);
              if (state.coinMarketChart.prices.length > 1) {
                return CoinInfoLineChart(
                  chartData: CoinInfoLineChartData(
                      coinMarketChart: state.coinMarketChart),
                );
              } else {
                return Container(
                    color: const Color.fromARGB(255, 241, 241, 241),
                    child: Center(
                      child: BlocBuilder<TimeSlotCubit, String>(
                        bloc: context.read<TimeSlotCubit>(),
                        builder: (context, state) {
                          return Text(
                            "No historical data for $state",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ));
              }
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
      ),
    );
  }
}
