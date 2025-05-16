import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Цветовые схемы
class AppColors {
  static const Color darkPrimary = Color(0xFF1A1A2E);
  static const Color darkSecondary = Color(0xFF16213E);
  static const Color lightPrimary = Color(0xFFE8F1F2);
  static const Color lightSecondary = Color(0xFFB8E0D2);
  static const Color accentBlue = Color(0xFF0E86D4);
}

// Провайдер темы
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  static final lightTheme = ThemeData(
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightPrimary,
    colorScheme: ColorScheme.light(
      primary: AppColors.accentBlue,
      secondary: AppColors.lightSecondary,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.accentBlue),
      bodyMedium: TextStyle(color: AppColors.accentBlue),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.accentBlue,
      secondary: AppColors.darkSecondary,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.accentBlue),
      bodyMedium: TextStyle(color: AppColors.accentBlue),
    ),
  );
} 