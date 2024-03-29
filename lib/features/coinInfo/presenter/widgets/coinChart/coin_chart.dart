import 'package:crypto_trends/core/widgets/custom_container_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../core/widgets/errors/error_message.dart';
import '../../../../../errors/error_types.dart';
import '../../../../../ui/icons/svg_icons.dart';
import '../../bloc/coinChartInfo/coininfo_bloc.dart';
import '../../cubit/time_slot_cubit.dart';
import '../../utils/coin_info_line_chart_data.dart';
import '../../utils/functions.dart';
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
    triggerGetCoinInfo(context: context, id: widget.id, days: "1");
  }

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    return CustomOpacityAnimation(
      duration: const Duration(seconds: 1),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<CoinInfoBloc, CoinInfoState>(
          builder: (context, state) {
            //*
            if (state is CoinInfoInitial || state is CoinInfoLoading) {
              return buildCoinInfoLoadingWidget();
            } else if (state is CoinInfoLoaded) {
              if (state.coinMarketChart.prices.length > 1) {
                return CoinInfoLineChart(
                  chartData: CoinInfoLineChartData(
                      coinMarketChart: state.coinMarketChart),
                );
              } else {
                return Container(
                    color: theme.disabledColor,
                    child: Center(
                      child: BlocBuilder(
                        bloc: context.read<TimeSlotCubit>(),
                        builder: (context, state) {
                          return Text(
                            "No historical data for $state",
                            style: const TextStyle(
                              fontFamily: 'Inter',
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
                  color: theme.disabledColor,
                  child: CustomErrorWidget(
                    onPressed: () async {
                      if (await InternetConnectionChecker().hasConnection) {
                        triggerGetCoinInfo(context: context, id: widget.id);
                      } else {
                        Fluttertoast.showToast(
                            msg: "You still Offline",
                            toastLength: Toast.LENGTH_SHORT,
                            textColor: theme.scaffoldBackgroundColor,
                            backgroundColor: theme.primaryColor);
                      }
                    },
                    icon: SvgIcons.noWifiLine,
                    msg: "No internet",
                  ),
                );
              }
            }
            return Container(
              color: theme.disabledColor,
              child: CustomErrorWidget(
                onPressed: () async {
                  triggerGetCoinInfo(context: context, id: widget.id);
                },
                icon: SvgIcons.badO,
                msg: "Something went wrong",
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCoinInfoLoadingWidget() {
    return const ContainerShimmer(
        width: double.infinity, height: 200, radius: 0);
  }
}
