import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());
}
