import 'package:flutter/material.dart';

class StylesApp {
  static ThemeData darkTheme() {
    return ThemeData.dark();
  }

  static ThemeData lightTheme() {
    return ThemeData.light();
  }

  static ThemeData obscureTheme() {
    return ThemeData.from(
        colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 53, 33, 90),
      onPrimary: Color.fromARGB(255, 16, 22, 77),
      secondary: Color.fromARGB(255, 0, 201, 124),
      onSecondary: Color.fromARGB(255, 0, 0, 0),
      error: Color.fromARGB(255, 0, 201, 124),
      onError: Color.fromARGB(255, 0, 0, 0),
      background: Color.fromARGB(255, 16, 22, 77),
      onBackground: Color.fromARGB(255, 57, 59, 80),
      surface: Color.fromARGB(255, 53, 33, 90),
      onSurface: Color.fromARGB(255, 0, 201, 124),
    ));
  }
}
