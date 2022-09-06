import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({
    Key? key,
    required this.width,
    required this.height,
    required this.radius,
    this.baseColor = const Color.fromARGB(255, 240, 240, 240),
    this.highlightColor = const Color.fromARGB(255, 251, 251, 251),
  }) : super(key: key);

  final double width;
  final double height;
  final double radius;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
