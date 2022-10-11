import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../ui/colors/colors.dart';

//Dark mode colors
const Color darkBaseColor = Color.fromARGB(255, 17, 17, 17);
const Color darkHighlightColor = Color.fromARGB(255, 36, 36, 36);

//Light mode colors
const Color lightBaseColor = AppColors.secondGrey;
const Color lightHighlightColor = Color.fromARGB(255, 251, 251, 251);


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
    //
    final theme = Theme.of(context);
    //
    final bool isDarkMode = theme.brightness == Brightness.dark;
    //
    Color finalbaseColor = isDarkMode ? darkBaseColor : lightBaseColor;
    Color finalHighlightColor = isDarkMode ? darkHighlightColor : lightHighlightColor;

    return Shimmer.fromColors(
      period: const Duration(milliseconds: 2500),
      baseColor: finalbaseColor,
      highlightColor: finalHighlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: finalbaseColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
