import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgIcons {
  chartLineUp,
  chartLineDown,
}

Map<SvgIcons, String> svgLink = {
  SvgIcons.chartLineUp: 'assets/svg/chart-line-up.svg',
  SvgIcons.chartLineDown: 'assets/svg/chat-arrow-down.svg',
};

class SvgIcon extends StatelessWidget {
  final Color? color;
  final double size;
  final SvgIcons? icon;
  const SvgIcon({
    Key? key,
    this.color = Colors.black,
    this.size = 20,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? SizedBox(
            child: SvgPicture.asset(svgLink[icon]!,
                width: size, color: color),
          )
        : Container();
  }
}
