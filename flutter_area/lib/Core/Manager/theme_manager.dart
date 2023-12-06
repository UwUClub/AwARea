import 'package:flutter/material.dart';

class ThemeManager {
  ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  void inverseThemeMode() =>
      themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
}
