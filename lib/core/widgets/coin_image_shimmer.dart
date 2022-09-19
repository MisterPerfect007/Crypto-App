
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CoinImageShimmer extends StatelessWidget {
  const CoinImageShimmer({
    Key? key, this.width = 40,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 246, 246, 246),
      highlightColor: Color.fromARGB(255, 251, 251, 251),
      child: Container(
        width: width,
        height: width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
      ),
    );
  }
}
