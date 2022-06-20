import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/coin_model.dart';
import '../cubit/scrollposition_cubit.dart';
import '../widgets/app_bar.dart';
import '../widgets/coin_list_view.dart';
import '../widgets/customFloatingActionButton/custom_floating_action_button.dart';
import '../widgets/single coin/single_coin.dart';
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
      floatingActionButton:
          CustomFloatingActionButton(context: context, scrollController: _scrollController),
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
                      child: RefreshIndicator(
                        onRefresh: () async {
                          gettingOrRefringCoinList(context);
                        },
                        color: AppColors.mainGreen ,
                        child: CoinListView(scrollController: _scrollController, coinList: coinList),
                      ),
                    ),
                  );
                } 
                else {
                  return const Text('Something went wrong');
                }
              })),
            ),
          ],
        ),
      ),
    );
  }
  void gettingOrRefringCoinList(BuildContext context){
    final coinListBloc = context.read<CoinListBloc>();
    final state = coinListBloc.state;
    if(state is CoinListLoaded){
      coinListBloc.add(const CoinListUpdate(currency: "usd", page: 1));
    }else {
      coinListBloc.add(const CoinListGet(currency: "usd", page: 1));
    }
  }
}
