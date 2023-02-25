import 'package:flutter/material.dart';

class StylesApp {
  static Color appPrimaryColor = const Color.fromARGB(255, 6, 126, 122);

  static ThemeData darkTheme(BuildContext context) {
    final ThemeData theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: const Color.fromARGB(255, 81, 82, 80)),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: const Color.fromARGB(255, 8, 103, 38)),
    );
  }

  /*static darkTheme() {
    final ThemeData theme = ThemeData.dark();
    return theme;
  }*/
}
