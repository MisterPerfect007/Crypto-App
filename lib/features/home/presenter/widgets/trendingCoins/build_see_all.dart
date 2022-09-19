import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../bloc/trending_coin/trending_coin_bloc.dart';
import '../../page/see_all_page.dart';
import '../trending_coin_cart.dart';

BlocBuilder<TrendingCoinsBloc, TrendingCoinsState> buildSeeAll(
    double sidePadding) {
  return BlocBuilder<TrendingCoinsBloc, TrendingCoinsState>(
      builder: (context, state) {
    if (state is TrendingCoinsLoaded) {
      List<Coin> coinList = state.coinList;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SeeAllPage(
              appBarTitle: "Trending Coins",
              body: CustomOpacityAnimation(
                  child: Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: sidePadding,
                  mainAxisSpacing: sidePadding,
                  children: List.generate(
                    coinList.length,
                    (index) => OpenContainer(
                      closedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      closedElevation: 1,
                      closedBuilder: (context, action) => TrendingCoinCart(
                          coin: coinList[index], action: action),
                      openBuilder: (context, action) =>
                          CoinInfoPage(coin: coinList[index], id: '',),
                    ),
                    // TrendingCoinCart(coin: coinList[index]),
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
