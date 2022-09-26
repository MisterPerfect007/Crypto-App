import 'dart:async';

import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/sorting_cubit.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/widgets/errors/error_message.dart';
import '../../../../errors/error_types.dart';
import '../../../../ui/icons/svg_icons.dart';
import '../cubit/scrollposition_cubit.dart';
import '../utils/utils_functions.dart';
import '../widgets/app_bar.dart';
import '../widgets/coin_list_shimmer.dart';
import '../widgets/coinListView/coin_list_view.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatefulWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  State<CoinListPage> createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  @override
  void initState() {
    super.initState();
    gettingOrRefringCoinList(context);
    Timer.periodic(const Duration(seconds: 60), (_) {
      gettingOrRefringCoinList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: const CoinPageAppBar(),
      ),
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SortingCriteria(),
            Expanded(
              child: BlocBuilder<CoinListBloc, CoinListState>(
                  builder: ((context, state) {
                // print(state);
                /*
                    !CoinListInitial
                   */
                if (state is CoinListInitial) {
                  return const Text('Initial state');
                } else if (state is CoinListLoading) {
                  /*
                    !CoinListLoading 
                   */
                  return const SizedBox(
                    child: CoinShimmer(),
                  );
                } else if (state is CoinListLoaded) {
                  /*
                    !CoinListLoaded
                   */
                  return NotificationListener(
                    onNotification: ((notification) {
                      context
                          .read<ScrollPositionCubit>()
                          .onScroll(_scrollController.position.pixels);
                      return true;
                    }),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        gettingOrRefringCoinList(context);

                        //delay just for showing the loading spinner for 2s
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      color: AppColors.mainGreen,
                      child: CoinListView(
                        scrollController: _scrollController,
                        coinList: sortCoinList(
                            coinList: state.coinList,
                            criteria: context.read<SortingCubit>().state),
                      ),
                    ),
                  );
                  /* 
                    !CoinListFailure
                   */
                } else if (state is CoinListFailure) {
                  if (state.errorType == ErrorType.noInternetConnection) {
                    return CustomErrorWidget(
                      msg: 'No internet',
                      icon: SvgIcons.noWifiLine,
                      onPressed: () async {
                        if (await InternetConnectionChecker().hasConnection) {
                          gettingOrRefringCoinList(context);
                        } else {
                          Fluttertoast.showToast(
                            msg: "You still Offline",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      },
                    );
                  }
                }
                return CustomErrorWidget(
                  msg: 'Something went wrong',
                  icon: SvgIcons.badO,
                  onPressed: () async {
                    gettingOrRefringCoinList(context);
                  },
                );
              })),
            ),
          ],
        ),
      ),
    );
  }
}
