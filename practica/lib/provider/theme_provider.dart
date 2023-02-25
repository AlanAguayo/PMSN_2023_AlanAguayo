import 'package:flutter/material.dart';
import 'package:practicauno/settings/styles.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(BuildContext context) {
    _themeData = StylesApp.darkTheme(context);
  }

  ThemeData? _themeData;
  getthemeData() => _themeData;
  setthemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
//button groups