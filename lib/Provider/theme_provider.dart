import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode theme = ThemeMode.system;

  String themeText = 'system';

  _getTheme(ThemeMode newTheme) async {
    if (newTheme == ThemeMode.system) {
      themeText = 'system';
    } else if (newTheme == ThemeMode.light) {
      themeText = 'light';
    } else if (newTheme == ThemeMode.dark) {
      themeText = 'dark';
    }
  }

  onChangeTheme(newTheme) async {
    theme = newTheme;
    _getTheme(theme);
    notifyListeners();
    var pref = await SharedPreferences.getInstance();
    pref.setString('themeText', themeText);
  }

  getTheme() async {
    var pref = await SharedPreferences.getInstance();
    themeText = pref.getString('themeText') ?? 'system';
    if (themeText == 'system') {
      theme = ThemeMode.system;
    } else if (themeText == 'light') {
      theme = ThemeMode.light;
    } else if (themeText == 'dark') {
      theme = ThemeMode.dark;
    }
    notifyListeners();
  }
}
