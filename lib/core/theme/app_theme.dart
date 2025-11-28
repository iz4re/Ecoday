import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF0B8F6E);
  static const Color secondaryGreen = Color(0xFF24C08E);
  static const Color accentYellow = Color(0xFFFFC857);
  static const Color cardBackground = Colors.white;
  static const Color textMuted = Color(0xFF6B7A7B);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF0FAF6),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
      secondary: accentYellow,
      surface: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      hintStyle: const TextStyle(color: textMuted, fontSize: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD8E5DD), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: primaryGreen, width: 1.6),
      ),
    ),
  );
}
