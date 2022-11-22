import 'package:flutter/material.dart';

import '../../../ui/colors/colors.dart';
import '../../../ui/icons/svg_icons.dart';

class Favorite extends StatelessWidget {
  const Favorite({
    Key? key,
    required this.isFavorite,
  }) : super(key: key);

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
        padding: EdgeInsets.only(
            left: sidePadding, right: sidePadding, top: 10, bottom: 10),
        child: SvgIcon(
          icon: isFavorite ? SvgIcons.favoriteSolid : SvgIcons.favoriteLine,
          color: isFavorite ? Colors.amber : AppColors.mainGrey,
        ));
  }
}
