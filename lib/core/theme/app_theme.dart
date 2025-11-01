import 'package:flutter/material.dart';
import 'package:mini_movies/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._(); // Private constructor for static class

  // Light Theme
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight,
    cardColor: AppColors.cardLight,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary.withValues(alpha: 0.1),
      selectionColor: AppColors.primary.withValues(alpha: 0.1),
      selectionHandleColor: AppColors.primary.withValues(alpha: 0.5),
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackgroundLight,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),

    iconTheme: IconThemeData(color: Colors.black87),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
    iconTheme: IconThemeData(color: Colors.white),
    cardColor: AppColors.cardDark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary.withValues(alpha: 0.3),
      selectionColor: AppColors.primary.withValues(alpha: 0.3),
      selectionHandleColor: AppColors.primary.withValues(alpha: 0.7),
    ),
      textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackgroundDark,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    ),
  );

  // Helper: Get theme based on Brightness
  static ThemeData getTheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return dark;
      case Brightness.light:
        return light;
    }
  }

  // Enum for theme modes (optional, for Provider/Riverpod/Bloc)
  static const ThemeMode lightMode = ThemeMode.light;
  static const ThemeMode darkMode = ThemeMode.dark;
  static const ThemeMode systemMode = ThemeMode.system;
}
