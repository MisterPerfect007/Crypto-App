
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../ui/colors/colors.dart';

class CoinImageShimmer extends StatelessWidget {
  const CoinImageShimmer({
    Key? key, this.width = 40,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondGrey,
      highlightColor: const Color.fromARGB(255, 234, 234, 234),
      child: Container(
        width: width,
        height: width,
        decoration: const BoxDecoration(
          color: AppColors.secondGrey,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
      ),
    );
  }
}
