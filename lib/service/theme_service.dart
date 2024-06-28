import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _key = "isDarkMode";

  // This method saves the theme preference to SharedPreferences
  Future<void> _saveThemeToPrefs(bool isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, isDarkMode);
  }

  // This method loads the theme preference from SharedPreferences
  Future<bool> loadThemeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  // This getter returns the current theme mode based on the preference
  Future<ThemeMode> get theme async {
    return await loadThemeFromPrefs() ? ThemeMode.dark : ThemeMode.light;
  }

  // This method switches the theme and updates the preference
  Future<void> switchTheme() async {
    final bool isDarkMode = await loadThemeFromPrefs();
    final ThemeMode newTheme = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    
    // Change the theme using GetX
    Get.changeThemeMode(newTheme);

    print("themm has switched");
    
    // Save the new theme preference
    await _saveThemeToPrefs(!isDarkMode);
  }
}
