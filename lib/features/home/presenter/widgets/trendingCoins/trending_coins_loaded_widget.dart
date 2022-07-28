import 'package:crypto_trends/features/home/presenter/widgets/trending_coin_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../coinList/domain/entities/coin.dart';

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
          children: 
            List.generate(4, (index) => TrendingCoinCart(coin: coinList[index]),),
          ),
      ),
    );
  }
}