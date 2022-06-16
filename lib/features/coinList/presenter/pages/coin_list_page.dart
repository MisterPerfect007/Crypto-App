import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/coin_model.dart';
import '../cubit/scrollposition_cubit.dart';
import '../widgets/app_bar.dart';
import '../widgets/single coin/single_coin.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context
        .read<CoinListBloc>()
        .add(const GetCoinList(currency: "usd", page: 1));
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
      floatingActionButton:
          buildFloatingActionButton(context, _scrollController),
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
                  return const Align(child: CircularProgressIndicator());
                } else if (state is CoinListLoaded) {
                  List<Coin> coinList = state.coinList;
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
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: coinList.length,
                          itemBuilder: ((context, i) {
                            return SingleCoin(
                              name: coinList[i].name,
                              image: coinList[i].image,
                              symbol: coinList[i].symbol,
                              currentPrice: coinList[i].currentPrice,
                              marketCapRank: coinList[i].marketCapRank,
                              priceChangePercentage7dInCurrency:
                                  coinList[i].priceChangePercentage7dInCurrency,
                              lastWeekData: coinList[i].sparklineIn7d?.price,
                            );
                          })),
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

  BlocBuilder<ScrollPositionCubit, Object?> buildFloatingActionButton(
      BuildContext context, ScrollController _scrollController) {
    return BlocBuilder(
      bloc: context.read<ScrollPositionCubit>(),
      builder: (context, state) {
        if (context.read<ScrollPositionCubit>().state > 10) {
          return BlocBuilder<CoinListBloc, CoinListState>(
            builder: (context, state) {
             return FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 10,
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                    );
                    if(state is CoinListLoaded) {
                      context.read<CoinListBloc>().add(UpdateCoinList(coinList: state.coinList));
                    }
                  },
                  child: const PersoIcon(icon: PersoIcons.arrowScrollUp),
                );},
          );
        } else {
          return Container();
        }
      },
    );
  }
}
