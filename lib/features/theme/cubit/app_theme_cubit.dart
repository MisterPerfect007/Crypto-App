import 'package:bloc/bloc.dart';
import 'package:crypto_trends/features/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:flutter/scheduler.dart';

import '../../../core/localStorage/keys.dart';
import '../../../core/localStorage/local_storage_key_value.dart';

final storage = di.sl<LocalStorageKeyValue>();

class AppThemeCubit extends Cubit<ThemeData> {
  AppThemeCubit() : super(getStartTheme());

  void switchTheme() async {
    if (state == AppTheme.darkTheme) {
      emit(AppTheme.lightTheme);
      await storage.setBool(themeKey, false);
    } else {
      emit(AppTheme.darkTheme);
      await storage.setBool(themeKey, true);
    }
  }
}

ThemeData getStartTheme() {
  final bool? isDarkMode = storage.getBool(themeKey);
  final brightness = SchedulerBinding.instance.window.platformBrightness;
  bool isSystemDarkMode = brightness == Brightness.dark;

  if (isDarkMode != null) {
    return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
  return isSystemDarkMode
      ? AppTheme.darkTheme
      : AppTheme.lightTheme;
}
