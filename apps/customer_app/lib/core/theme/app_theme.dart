import 'package:criminal_brushes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.acidLime,
      brightness: Brightness.light,
      primary: AppColors.black,
      secondary: AppColors.pink,
      surface: AppColors.white,
      error: AppColors.danger,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.black,
          fontSize: 64,
          height: 0.95,
          fontWeight: FontWeight.w900,
          letterSpacing: -2,
        ),
        headlineMedium: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          color: AppColors.inkGray,
          fontSize: 18,
          height: 1.45,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          minimumSize: const Size(160, 52),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
          shape: const RoundedRectangleBorder(),
        ),
      ),
    );
  }
}
