import 'package:animations/animations.dart';
import 'package:crypto_trends/features/home/presenter/widgets/top10Coins/top_10_coin_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../bloc/top10/top_10_bloc.dart';
import '../../page/see_all_page.dart';

BlocBuilder<Top10Bloc, Top10State> buildTop10SeeAll(double sidePadding) {
  return BlocBuilder<Top10Bloc, Top10State>(builder: (context, state) {
    //
    final theme = Theme.of(context);
    if (state is Top10Loaded) {
      List<Coin> coinList = state.coinList;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SeeAllPage(
              appBarTitle: "Top 10 Coins",
              body: CustomOpacityAnimation(
                  child: Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: sidePadding,
                  mainAxisSpacing: sidePadding,
                  children: List.generate(
                    10,
                    (index) => OpenContainer(
                      closedColor: theme.cardColor,
                      closedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      closedElevation: 1,
                      closedBuilder: (context, action) =>
                          Top10CoinCart(coin: coinList[index], action: action),
                      openBuilder: (context, action) => CoinInfoPage(
                        coin: coinList[index],
                        id: '',
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Text(
            "See all",
            style: GoogleFonts.inter(
                color: AppColors.mainGreen,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
      );
    } else {
      return Container();
    }
  });
}
