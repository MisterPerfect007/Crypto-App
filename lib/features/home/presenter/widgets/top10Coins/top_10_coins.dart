import 'package:animations/animations.dart';
import 'package:crypto_trends/features/coinList/presenter/pages/coin_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../core/widgets/errors/failed_request.dart';
import '../../../../../errors/error_types.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../../../../coinList/presenter/cubit/sorting_cubit.dart';
import '../../../../coinList/presenter/utils/utils_functions.dart';
import 'build_see_all.dart';
import 'top_10_coin_cart.dart';

    void gettingTop10List(BuildContext context) {
      final coinListBloc = context.read<CoinListBloc>();
      final state = coinListBloc.state;
      if (state is CoinListLoaded) {
        coinListBloc.add(const CoinListUpdate(
            currency: "usd", sortingCriteria: {"by": 'Rank', 'desc': true}));
      } else if (state is! CoinListLoading) {
        coinListBloc.add(const CoinListGet(
            currency: "usd", sortingCriteria: {"by": 'Rank', 'desc': true}));
      }
    }
class Top10Coins extends StatelessWidget {
  const Top10Coins({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;


    gettingTop10List(context);

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CoinListPage()));
                },
                child: Text(
                  "Top 10 Coins",
                  style: GoogleFonts.inter(
                      color: AppColors.mainBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              Expanded(child: Container()),
              buildTop10SeeAll(sidePadding),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<CoinListBloc, CoinListState>(
          builder: (context, state) {
            if (state is CoinListLoading) {
              return Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: Row(children: [
                  Column(children: const [
                    Top10CoinCart(isLoading: true),
                    Top10CoinCart(isLoading: true),
                  ]),
                  SizedBox(width: sidePadding),
                  Column(children: const [
                    Top10CoinCart(isLoading: true),
                    Top10CoinCart(isLoading: true),
                  ]),
                ]),
              );
            } else if (state is CoinListLoaded) {
              List<Coin> coinList = state.coinList;
              return CustomOpacityAnimation(
                  child: Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: sidePadding,
                  mainAxisSpacing: sidePadding,
                  children: List.generate(
                    4,
                    (index) => OpenContainer(
                      closedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      closedElevation: 1,
                      closedBuilder: (context, action) =>
                          Top10CoinCart(coin: coinList[index], action: action),
                      openBuilder: (context, action) =>
                          CoinInfoPage(coin: coinList[index]),
                    ),
                  ),
                ),
              ));
            } else if (state is CoinListFailure) {
              if (state.errorType == ErrorType.noInternetConnection) {
                return FailedRequest(
                  small: true,
                  icon: PersoIcons.coloredNoWifi,
                  title: "You're currently offline",
                  secondTitle:
                      "Check your internet connection and try to refresh.",
                  buttonOnPressed: () {
                    // gettingOrRefringCoinList(context);
                  },
                  buttonText: "Refresh",
                );
              }
            }
            return FailedRequest(
              small: true,
              icon: PersoIcons.coloredRemove,
              title: "Something went wrong",
              secondTitle:
                  "Something went wrong on the back side, please try again.",
              buttonOnPressed: () {
                // gettingOrRefringCoinList(context);
              },
              buttonText: "Try again",
            );
          },
        )
      ]),
    );
  }
}
