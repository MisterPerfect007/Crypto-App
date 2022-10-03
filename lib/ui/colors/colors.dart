import 'package:flutter/material.dart';

class AppColors{
  static const Color lightBg = Color.fromARGB(255, 255, 255, 255);

  static const Color pureBlack = Color.fromARGB(255, 0, 0, 0);
  static const Color pureRed = Color.fromARGB(255, 255, 0, 0);

  static const Color mainGreen = Color(0xFF08A86D);
  static const Color mainWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color mainBlack = Color.fromARGB(255, 52, 52, 52);
  static const Color mainGrey = Color.fromARGB(255, 123, 123, 123);

  static const Color secondGrey = Color.fromARGB(255, 219, 219, 219);

  /* C4C4C4 */
  static const Color thirdGrey = Color(0xffC4C4C4);

  static const Color grey1 = Color.fromARGB(255, 56, 56, 56);

  
  static const Color secondGreen = Color.fromARGB(255, 8, 168, 56);

  static const MaterialColor colorPrimarySwatch = MaterialColor(
    0xFF08A86D,
     <int, Color>{
      50: AppColors.mainGreen,
      100: AppColors.mainGreen,
      200: AppColors.mainGreen,
      300: AppColors.mainGreen,
      400: AppColors.mainGreen,
      500: AppColors.mainGreen,
      600: AppColors.mainGreen,
      700: AppColors.mainGreen,
      800: AppColors.mainGreen,
      900: AppColors.mainGreen,
    },
  );
}