import 'package:crypto_trends/features/home/presenter/widgets/trending_coin_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animations/animations.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../top10Coins/top_10_coin_cart.dart';

class TrendingCoinsLoadedWidget extends StatelessWidget {
  const TrendingCoinsLoadedWidget({
    Key? key,
    required this.coinList,
  }) : super(key: key);

  final List<Coin> coinList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

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
                  TrendingCoinCart(coin: coinList[index], action: action),
              openBuilder: (context, action) =>
                          CoinInfoPage(coin: coinList[index]),
            ),
            // TrendingCoinCart(coin: coinList[index]),
          ),
        ),
      ),
    );
  }
}
