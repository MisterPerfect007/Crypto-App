import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../ui/colors/colors.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({
    Key? key,
    required this.width,
    required this.height,
    required this.radius,
  }) : super(key: key);

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 240, 240, 240),
      highlightColor: Color.fromARGB(255, 251, 251, 251),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
