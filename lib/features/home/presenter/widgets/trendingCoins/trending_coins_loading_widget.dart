
import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:crypto_trends/features/home/presenter/widgets/trending_coin_cart.dart';
import 'package:flutter/material.dart';

class TrendingCoinsLoadingWidget extends StatelessWidget {
  const TrendingCoinsLoadingWidget({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Padding(
      padding: EdgeInsets.only(left: sidePadding),
      child: CustomOpacityAnimation(
        child: Column(
          children: [
            Row(
              children: [
                const TrendingCoinCart(isLoading: true),
                SizedBox(width: sidePadding),
                const TrendingCoinCart(isLoading: true),
              ],
            ),
            Row(
              children: [
                const TrendingCoinCart(isLoading: true),
                SizedBox(width: sidePadding),
                const TrendingCoinCart(isLoading: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}