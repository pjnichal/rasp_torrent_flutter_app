import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Colors.grey.shade800,
    backgroundColor: Color(0xFF121212),
    accentColor: Colors.white,
    primaryColor: Colors.green,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: Color(0xFFE4E6EB),//Color(0xFFB0B3B8)
    backgroundColor: Colors.white,
    accentColor: Colors.white,
    primaryColor: Colors.green,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}