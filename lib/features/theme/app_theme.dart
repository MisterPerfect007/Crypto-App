import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: AppColors.colorPrimarySwatch,
    scaffoldBackgroundColor: AppColors.pureWhite,
    bottomAppBarColor: AppColors.pureBlack,
    disabledColor: AppColors.mainGrey,
    errorColor: AppColors.pureRed,
  );

  static final darkTheme = ThemeData(
    primarySwatch: AppColors.colorPrimarySwatch,
    scaffoldBackgroundColor: AppColors.pureWhite,
    bottomAppBarColor: AppColors.pureBlack,
    disabledColor: AppColors.mainGrey,
    errorColor: AppColors.pureRed,
  );
}
