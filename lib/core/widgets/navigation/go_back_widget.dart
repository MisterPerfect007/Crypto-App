
import 'package:flutter/material.dart';

import '../../../ui/colors/colors.dart';
import '../../../ui/icons/svg_icons.dart';

class GoBack extends StatelessWidget {
  const GoBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.grey,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              height: 50,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: const SvgIcon(
                icon: SvgIcons.chevronLeft,
                size: 25,
                color: AppColors.pureBlack,
              ))),
    );
  }
}