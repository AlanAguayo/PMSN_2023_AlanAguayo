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
          primary: Color(0xff006400),
          onPrimary: Colors.white,
          secondary: Color(0xff8b4513),
          onSecondary: Colors.white,
          error: Color(0xffb00020),
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Color(0xffe6d8ad),
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)));
  }

  /*static ThemeData obscureTheme() {
    return ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 0, 201, 124),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          secondary: Color.fromARGB(255, 0, 201, 124),
          onSecondary: Color.fromARGB(255, 0, 0, 0),
          error: Color.fromARGB(255, 0, 201, 124),
          onError: Color.fromARGB(255, 0, 0, 0),
          background: Color.fromARGB(255, 16, 22, 77),
          onBackground: Color.fromARGB(255, 57, 59, 80),
          surface: Color.fromARGB(255, 53, 33, 90),
          onSurface: Color.fromARGB(255, 0, 201, 124),
        ),
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)));
  }*/
}
