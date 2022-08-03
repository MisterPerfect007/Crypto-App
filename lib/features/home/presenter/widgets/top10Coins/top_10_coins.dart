import 'package:animations/animations.dart';
import 'package:crypto_trends/features/coinList/presenter/widgets/sorting%20criteria/sorting_criteria.dart';
import 'package:crypto_trends/features/home/presenter/page/see_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../../../../coinList/presenter/cubit/sorting_cubit.dart';
import 'top_10_coin_cart.dart';

class Top10Coins extends StatelessWidget {
  const Top10Coins({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    context.read<CoinListBloc>().add(CoinListGet(
        currency: "usd", sortingCriteria: context.read<SortingCubit>().state));

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Row(
            children: [
              Text(
                "Top 10 Coins",
                style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Expanded(child: Container()),
              buildSeeAll(sidePadding),
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
            } else {
              return Top10CoinCart();
            }
          },
        )
      ]),
    );
  }

  BlocBuilder<CoinListBloc, CoinListState> buildSeeAll(double sidePadding) {
    return BlocBuilder<CoinListBloc, CoinListState>(builder: (context, state) {
      if (state is CoinListLoaded) {
        List<Coin> coinList = state.coinList;
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SeeAllPage(
                appBarTitle: "Top 10 Coins",
                body: CustomOpacityAnimation(
                    child: Padding(
                  padding:
                      EdgeInsets.only(left: sidePadding, right: sidePadding),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: sidePadding,
                    mainAxisSpacing: sidePadding,
                    children: List.generate(
                      10,
                      (index) => OpenContainer(
                        closedShape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        closedElevation: 1,
                        closedBuilder: (context, action) => Top10CoinCart(
                            coin: coinList[index], action: action),
                        openBuilder: (context, action) =>
                            CoinInfoPage(coin: coinList[index]),
                      ),
                    ),
                  ),
                )),
              ),
            ));
          },
          child: Text(
            "See all",
            style: GoogleFonts.inter(
                color: AppColors.mainGreen,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
