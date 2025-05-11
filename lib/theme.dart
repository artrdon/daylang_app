import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(context) {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    print(_themeMode);
    print(Theme.of(context).textTheme.bodyLarge?.color);
    print(context);
    notifyListeners();
  }
}