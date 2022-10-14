import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    return SafeArea(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              left: sidePadding, right: sidePadding, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: AppColors.mainGrey.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 0.5,
                  spreadRadius: 0),
            ],
          ),
          child: Text(
            "Settings 🗝️",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          )),
    );
  }
}
