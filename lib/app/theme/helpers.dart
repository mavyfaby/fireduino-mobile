import 'package:flutter/material.dart';
import 'theme.dart';

/// Get theme data
Map<String, ThemeData> getTheme(BuildContext context) {
  return {
    'light': ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: Color.alphaBlend(
        lightColorScheme.primary.withOpacity(0.05),
        lightColorScheme.surface,
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: lightColorScheme.onSurface,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    'dark': ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: Color.alphaBlend(
        darkColorScheme.primary.withOpacity(0.05),
        darkColorScheme.surface,
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: darkColorScheme.onSurface,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  };
}
