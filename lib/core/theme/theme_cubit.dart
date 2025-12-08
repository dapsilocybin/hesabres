import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'color_presets.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(
        ThemeState(mode: ThemeMode.system, seedColor: AppColorPresets.green),
      );

  void setThemeMode(ThemeMode mode) => emit(state.copyWith(mode: mode));

  void setSeedColor(Color color) => emit(state.copyWith(seedColor: color));

  ThemeData get light => AppTheme.light(state.seedColor);
  ThemeData get dark => AppTheme.dark(state.seedColor);
}
