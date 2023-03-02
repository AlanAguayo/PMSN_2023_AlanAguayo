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
            primary: Color.fromARGB(255, 8, 103, 38),
            onPrimary: Color.fromARGB(255, 8, 103, 38),
            secondary: Color.fromARGB(255, 8, 103, 38),
            onSecondary: Color.fromARGB(255, 8, 103, 38),
            error: Color.fromARGB(255, 8, 103, 38),
            onError: Color.fromARGB(255, 8, 103, 38),
            background: Color.fromARGB(255, 8, 103, 38),
            onBackground: Color.fromARGB(255, 8, 103, 38),
            surface: Color.fromARGB(255, 8, 103, 38),
            onSurface: Color.fromARGB(255, 8, 103, 38)));
  }
}
