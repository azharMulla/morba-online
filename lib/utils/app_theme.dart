import 'package:flutter/material.dart';

/// App theme colors centralized for easy maintenance and consistency
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2B4D1B);
  static const Color secondary = Color(0xFF59772F);
  static const Color tertiary = Color(0xFFAFA77B);
  static const Color background = Color(0xFF96793D);

  // Common UI Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  
  // Opacity Variants
  static Color tertiaryLight = tertiary.withOpacity(0.3);
  
  // Social Media Colors
  static const Color whatsappGreen = Color(0xFF25D366);
}

/// Theme data factory for creating consistent app themes
class AppTheme {
  /// Creates the main theme for the app
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        background: AppColors.background,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.secondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: AppColors.white,
        hintStyle: const TextStyle(color: AppColors.secondary),
      ),
    );
  }
}
