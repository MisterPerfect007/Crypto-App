import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';


class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColors.colorPrimarySwatch,
    scaffoldBackgroundColor: AppColors.pureWhite,
    bottomAppBarColor: AppColors.pureBlack,
    disabledColor: AppColors.secondGrey,
    errorColor: AppColors.pureRed,
    primaryColor: AppColors.mainBlack
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColors.colorPrimarySwatch,
    scaffoldBackgroundColor: AppColors.pureBlack,
    bottomAppBarColor: AppColors.pureBlack,
    disabledColor: const Color.fromARGB(255, 57, 57, 57),
    errorColor: AppColors.pureRed,
    primaryColor: const Color(0xDBFFFFFF),
    cardColor: const Color.fromARGB(83, 50, 50, 50),
    // cardColor: const Color.fromARGB(255, 39, 39, 39),
  );
}
