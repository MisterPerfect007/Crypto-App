import 'package:flutter/material.dart';

import 'custom_container_shimmer.dart';


class CoinImageShimmer extends StatelessWidget {
  const CoinImageShimmer({
    Key? key, this.width = 40,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return ContainerShimmer(height: width, radius: width, width: width,);
  }
}
