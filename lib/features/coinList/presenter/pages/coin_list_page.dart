import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/pagination_cubit.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/sorting_cubit.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../cubit/scrollposition_cubit.dart';
import '../widgets/app_bar.dart';
import '../widgets/coin_list_shimmer.dart';
import '../widgets/coinListView/coin_list_view.dart';
import '../widgets/customFloatingActionButton/custom_floating_action_button.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    gettingOrRefringCoinList(context);
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
      floatingActionButton: SpeedDial(
          backgroundColor: AppColors.mainBlack,
          icon: Icons.add,
          children: [
            SpeedDialChild(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                label: "Scroll to top",
                child: CustomFloatingActionButton(
                  scrollController: _scrollController,
                  context: context,
                ))
          ]),
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SortingCriteria(),
            Expanded(
              child: BlocBuilder<CoinListBloc, CoinListState>(
                  builder: ((context, state) {
                if (state is CoinListInitial) {
                  return const Text('Initial state');
                } else if (state is CoinListLoading) {
                  /*
                  *CoinListLoading 
                   */
                  return const SizedBox(
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(
                        androidOverscrollIndicator:
                            AndroidOverscrollIndicator.stretch,
                      ),
                      child: CoinShimmer(),
                    ),
                  );
                } else if (state is CoinListLoaded) {
                  /*
                  *CoinListLoading 
                   */
                  return ScrollConfiguration(
                    behavior: const ScrollBehavior(
                        androidOverscrollIndicator:
                            AndroidOverscrollIndicator.stretch),
                    child: NotificationListener(
                      onNotification: ((notification) {
                        context
                            .read<ScrollPositionCubit>()
                            .onScroll(_scrollController.position.pixels);
                        return true;
                      }),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await gettingOrRefringCoinList(context);
                        },
                        color: AppColors.mainGreen,
                        child: CoinListView(
                          scrollController: _scrollController,
                          coinList: state.coinList,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              })),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gettingOrRefringCoinList(BuildContext context) async {
    final coinListBloc = context.read<CoinListBloc>();
    final criteria = context.read<SortingCubit>().state;
    final state = coinListBloc.state;
    final int pageToFetch = context.read<PaginationCubit>().state;
    if (state is CoinListLoaded) {
      coinListBloc.add(
          CoinListUpdate(currency: "usd", page: pageToFetch, sortingCriteria: criteria));
      
      //delay just for showing the loading spinner for 2s
      await Future.delayed(const Duration(seconds: 2));
    } else {
      coinListBloc.add(CoinListGet(currency: "usd", page: pageToFetch));
    }
  }
}
