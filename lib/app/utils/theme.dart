import 'package:flutter/material.dart';

/// Get the name of the brightness mode
String getThemeModeName(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.dark:
      return 'Dark';
    case ThemeMode.light:
      return 'Light';
    default:
      return 'System';
  }
}

/// Get themeMode from name
ThemeMode getThemeMode(String name) {
  switch (name) {
    case 'Dark':
      return ThemeMode.dark;
    case 'Light':
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}