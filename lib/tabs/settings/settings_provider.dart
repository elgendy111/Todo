import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  SharedPreferences? prefs;

  bool get isDark => themeMode == ThemeMode.dark;

  void changeThemeMode(ThemeMode selectedThemeMode) {
    themeMode = selectedThemeMode;
    notifyListeners();
  }

  void changeLanguage(String selectedLang) {
    language = selectedLang;
    notifyListeners();
  }

  Future setTheme(ThemeMode themeMode) async {
    prefs = await SharedPreferences.getInstance();
    String themeMode = isDark ? 'dark' : 'light';
    await prefs!.setString('theme', themeMode);
  }

  Future<void> loadTheme() async {
    prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs!.getString('theme');
    if (savedTheme != null) {
      themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  Future setLanguage(String language) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('language', language);
  }

  Future<void> loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs!.getString('language');
    if (savedLanguage != null) {
      language = savedLanguage;
    }
    notifyListeners();
  }
}
