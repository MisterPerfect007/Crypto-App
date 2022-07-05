import 'package:flutter/material.dart';

enum PersoIcons {
  home,
  list,
  setting,
  person,
  search,
  searchLight,
  searchXl,
  searchMd,
  more,
  starFill,
  starFill1,
  starFill2,
  starOutline,
  leftArrow,
  leftArrow1,
  arrowDown,
  arrowUp,
  arrowUp1,
  arrowLeft,
  arrowScrollUp,
  angleLeft,
  angleRight,
  angleSmallUp,
  coloredNoWifi,
  coloredRemove,
}

Map<PersoIcons, String> iconName = {
  PersoIcons.home: 'assets/icons/home.png',
  PersoIcons.list: 'assets/icons/liste.png',
  PersoIcons.setting: 'assets/icons/setting.png',
  PersoIcons.person: 'assets/icons/person.png',
  PersoIcons.search: 'assets/icons/search.png',
  PersoIcons.searchLight: 'assets/icons/search_light.png',
  PersoIcons.searchXl: 'assets/icons/search_xl.png',
  PersoIcons.searchMd: 'assets/icons/search_md.png',
  PersoIcons.more: 'assets/icons/more.png',
  PersoIcons.starFill: 'assets/icons/star_fille.png',
  PersoIcons.starFill1: 'assets/icons/star.png',
  PersoIcons.starFill2: 'assets/icons/star(2).png',
  PersoIcons.starOutline: 'assets/icons/star_2.png',
  PersoIcons.leftArrow: 'assets/icons/left_arrow.png',
  PersoIcons.leftArrow1: 'assets/icons/left_arrow_1.png',
  PersoIcons.arrowDown: 'assets/icons/arrow_down.png',
  PersoIcons.arrowUp: 'assets/icons/arrow_up.png',
  PersoIcons.arrowUp1: 'assets/icons/arrow_up_1.png',
  PersoIcons.arrowLeft: 'assets/icons/left_arrow_1.png',
  PersoIcons.arrowScrollUp: 'assets/icons/up_scroll_arrow.png',
  PersoIcons.angleLeft: 'assets/icons/angle-left.png',
  PersoIcons.angleRight: 'assets/icons/angle-right.png',
  PersoIcons.angleSmallUp: 'assets/icons/angle-small-up(1).png',
  PersoIcons.coloredNoWifi: 'assets/icons/colorful-icons/no-wifi.png',
  PersoIcons.coloredRemove: 'assets/icons/colorful-icons/remove.png',

};

/// PersonIcon
///
class PersoIcon extends StatelessWidget {
  final Color? color;
  final double size;
  final PersoIcons icon;
  const PersoIcon({
    Key? key,
    this.color = Colors.black,
    this.size = 20,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset(
        iconName[icon]!,
        color: color,
        width: size,
        // scale: 12,
      ),
    );
  }
}
