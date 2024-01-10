import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  ThemeManager() {
    final Future<SharedPreferences> prefsF = SharedPreferences.getInstance();
    prefsF.then((SharedPreferences prefs) {
      final String? themeMode = prefs.getString('themeMode');
      if (themeMode != null) {
        themeModeNotifier.value = themeMode == 'light'
            ? ThemeMode.light
            : themeMode == 'dark'
                ? ThemeMode.dark
                : ThemeMode.system;
      }
    });
  }

  ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  void inverseThemeMode() {
    themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    final Future<SharedPreferences> prefsF = SharedPreferences.getInstance();
    prefsF.then((SharedPreferences prefs) {
      prefs.setString(
          'themeMode',
          themeModeNotifier.value == ThemeMode.light
              ? 'light'
              : themeModeNotifier.value == ThemeMode.dark
                  ? 'dark'
                  : 'system');
    });
  }
}
