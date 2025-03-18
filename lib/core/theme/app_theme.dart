import 'package:flutter/material.dart';

class AppTheme {
  // Font family constants
  static const String fontFamily = 'CircularStd-Book';

  // App colors
  static const Color primaryColor = Color(0xFF24786D);
  static const Color secondaryColor = Color(0xFF26A69A);
  static const Color backgroundColor = Colors.white;
  static const Color textColorPrimary = Color(0xFF212121);
  static const Color textColorSecondary = Color(0xFF797C7B);
  static const Color textColorTertiary = Color(0xFFCDD1D0);
    static const Color inactiveBottomNavItemColor = Color(0xFF797C7B);

  // Theme data
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColorPrimary),
      ),
      // Add more theme configurations as needed
    );
  }
}
