part of 'app_theme_cubit.dart';

abstract class AppThemeState extends Equatable {
  const AppThemeState();

  @override
  List<Object> get props => [];
}

class AppThemeCurrent extends AppThemeState {
  final ThemeData appTheme;
  const AppThemeCurrent(this.appTheme);
}
