import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Centralized theme data for the app.
abstract final class AppTheme {
  static final ThemeData light = ThemeData.light(useMaterial3: true);
  static final ThemeData dark = ThemeData.dark(useMaterial3: true);
}

class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() => ThemeState(isDark: true);

  void toggleTheme() => state = ThemeState(isDark: !state.isDark);
}

class ThemeState {
  ThemeState({required this.isDark});

  final bool isDark;
}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  () => ThemeNotifier(),
);
