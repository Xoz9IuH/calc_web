import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme_mode';

/// Глобальный контроллер темы. Выбор сохраняется между перезагрузками.
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.light);

Future<void> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final raw = prefs.getString(_themeKey);
  themeModeNotifier.value =
      raw == 'dark' ? ThemeMode.dark : ThemeMode.light;
}

Future<void> setThemeMode(ThemeMode mode) async {
  themeModeNotifier.value = mode;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_themeKey, mode == ThemeMode.dark ? 'dark' : 'light');
}
