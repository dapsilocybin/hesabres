import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode mode;
  final Color seedColor;

  const ThemeState({required this.mode, required this.seedColor});

  ThemeState copyWith({
    ThemeMode? mode,
    Color? seedColor,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      seedColor: seedColor ?? this.seedColor,
    );
  }
}

