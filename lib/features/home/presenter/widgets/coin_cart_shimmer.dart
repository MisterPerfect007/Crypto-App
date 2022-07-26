import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../ui/colors/colors.dart';

class CoinCartShimmer extends StatelessWidget {
  const CoinCartShimmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 237, 237, 237),
      highlightColor: Color.fromARGB(255, 249, 249, 249),
      child: Container(
        height: 120,
        width: width / 2,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      )
    );
  }
}