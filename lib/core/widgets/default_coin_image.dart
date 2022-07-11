
import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';

class DefaultCoinImage extends StatelessWidget {
  const DefaultCoinImage({
    Key? key,
    required this.name, this.width = 40,
  }) : super(key: key);

  final String name;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.secondGrey,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Text(
        name[0],
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.mainWhite),
      ),
    );
  }
}
