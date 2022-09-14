import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_container_shimmer.dart';

class SearchItemShimmer extends StatelessWidget {
  const SearchItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    return Container(
        padding: EdgeInsets.only(
            top: 5, bottom: 5, left: sidePadding, right: sidePadding),
        child: Row(children:  [
          const ContainerShimmer(
            width: 25,
            height: 25,
            radius: 25,
          ),
          const SizedBox(width: 10),
          const ContainerShimmer(
            width: 70,
            height: 10,
            radius: 5,
          ),
          const SizedBox(width: 10),
          const ContainerShimmer(
            width: 20,
            height: 10,
            radius: 5,
          ),
          Expanded(child: Container()),
          const ContainerShimmer(
            width: 10,
            height: 20,
            radius: 5,
          ),
        ]));
  }
}