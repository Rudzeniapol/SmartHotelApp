import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth_screen.dart';
import 'screens/guest_home_screen.dart';
import 'screens/admin_home_screen.dart';
import 'screens/booking_screen.dart';
import 'providers/theme_provider.dart';

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

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hotel',
      theme: context.watch<ThemeProvider>().currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(),
        '/guest': (context) => GuestHomeScreen(),
        '/admin': (context) => AdminHomeScreen(),
        '/booking': (context) => BookingScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data as SharedPreferences;
          final phone = prefs.getString('phone');
          final userRole = prefs.getString('userRole');

          if (phone != null && userRole != null) {
            return userRole == 'admin' ? AdminHomeScreen() : GuestHomeScreen();
          }
          return AuthScreen();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
