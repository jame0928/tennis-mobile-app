import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const navy = Color(0xFF0B1F3A);
  const blue = Color(0xFF1E63D8);

  final colorScheme =
      ColorScheme.fromSeed(
        seedColor: blue,
        brightness: Brightness.light,
      ).copyWith(
        primary: blue,
        secondary: const Color(0xFF18A999),
        error: const Color(0xFFDC2626),
        surface: Colors.white,
      );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFFF3F4F6),
    appBarTheme: const AppBarTheme(
      backgroundColor: navy,
      foregroundColor: Colors.white,
    ),
    useMaterial3: true,
  );
}
