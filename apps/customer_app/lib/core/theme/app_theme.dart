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
      scaffoldBackgroundColor: AppColors.paper,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.black,
          fontSize: 56,
          height: 0.95,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
        headlineLarge: TextStyle(
          color: AppColors.black,
          fontSize: 36,
          height: 1.05,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
        headlineMedium: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(
          color: AppColors.inkGray,
          fontSize: 18,
          height: 1.45,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.paper,
        foregroundColor: AppColors.black,
        elevation: 0,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          minimumSize: const Size(160, 52),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.black,
          minimumSize: const Size(120, 48),
          side: const BorderSide(color: AppColors.black, width: 1.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.black, width: 1.6),
        ),
      ),
    );
  }
}
