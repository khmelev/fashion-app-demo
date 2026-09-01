import 'package:flutter/material.dart';

/// Centralized theme data for the app.
abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.deepPurple,
  );
}
