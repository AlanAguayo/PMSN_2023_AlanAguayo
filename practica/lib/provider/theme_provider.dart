import 'package:flutter/material.dart';
import 'package:practicauno/settings/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeData get currentTheme => _currentTheme;

  String getTheme() {
    String theme = "light";
    if (_currentTheme == ThemeData.dark()) {
      theme = 'dark';
    }
    if (_currentTheme == ThemeData.light()) {
      theme = 'light';
    }
    if (_currentTheme == StylesApp.obscureTheme()) {
      theme = 'obscure';
    }
    return theme;
  }

  ThemeProvider(String theme) {
    switch (theme) {
      case 'dark':
        _currentTheme = ThemeData.dark();
        break;
      case 'light':
        _currentTheme = ThemeData.light();
        break;
      case 'obscure':
        _currentTheme = StylesApp.obscureTheme();
        break;
      default:
        _currentTheme = StylesApp.obscureTheme();
        break;
    }
  }

  void toggleTheme(theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (theme) {
      case 'dark':
        _currentTheme = ThemeData.dark();
        sharedPreferences.setString('theme', 'dark');
        break;
      case 'light':
        _currentTheme = ThemeData.light();
        sharedPreferences.setString('theme', 'light');
        break;
      case 'obscure':
        _currentTheme = StylesApp.obscureTheme();
        sharedPreferences.setString('theme', 'obscure');
        break;
      default:
        _currentTheme = StylesApp.darkTheme();
        sharedPreferences.setString('theme', 'dark');
        break;
    }
    notifyListeners();
  }
}
