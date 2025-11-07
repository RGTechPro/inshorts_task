import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFFFFA500);
  static const Color accentColor = Color(0xFFFFB300);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color errorColor = Color(0xFFCF6679);

  // Text Colors
  static const Color primaryTextColor = Color(0xFFFFFFFF);
  static const Color secondaryTextColor = Color(0xFFB3B3B3);
  static const Color disabledTextColor = Color(0xFF666666);

  // Icon Colors
  static const Color primaryIconColor = Color(0xFFFFFFFF);
  static const Color secondaryIconColor = Color(0xFFB3B3B3);
  static const Color accentIconColor = Color(0xFFFFC107);

  // Card Colors
  static const Color cardColor = Color(0xFF2C2C2C);
  static const Color cardHoverColor = Color(0xFF363636);

  // Rating Colors
  static const Color ratingColor = Color(0xFFFFC107);
  static const Color starColor = Color(0xFFFFB300);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color infoColor = Color(0xFF2196F3);

  // Overlay Colors
  static const Color overlayColor = Color(0xBF000000);
  static const Color shimmerBaseColor = Color(0xFF2C2C2C);
  static const Color shimmerHighlightColor = Color(0xFF363636);

  // Border Colors
  static const Color borderColor = Color(0xFF424242);
  static const Color dividerColor = Color(0xFF2C2C2C);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      colorScheme: const ColorScheme.dark(
        primary: secondaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: primaryTextColor,
        onSecondary: primaryTextColor,
        onSurface: primaryTextColor,
        onError: primaryTextColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: primaryTextColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: primaryIconColor,
        ),
      ),
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      iconTheme: const IconThemeData(
        color: primaryIconColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: primaryTextColor,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: primaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: primaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: secondaryTextColor,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: secondaryTextColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: primaryTextColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: secondaryColor, width: 2),
        ),
        hintStyle: const TextStyle(color: secondaryTextColor),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cardColor,
        selectedColor: secondaryColor,
        disabledColor: surfaceColor,
        labelStyle: const TextStyle(color: primaryTextColor),
        secondaryLabelStyle: const TextStyle(color: primaryTextColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
