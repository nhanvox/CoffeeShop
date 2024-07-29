import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffFFFEF2),
    primaryColor: const Color(0xffF2F2F2),
    colorScheme: const ColorScheme.light().copyWith(
      secondary: const Color(0xffF2F2F2),
      // Màu tùy chỉnh cho light theme
    ),
  );
  static ThemeData blackTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff2A4261),
    primaryColor: const Color(0xff1E2334),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: const Color(0xff1E2334), // Màu tùy chỉnh cho light theme
    ),
  );
}
