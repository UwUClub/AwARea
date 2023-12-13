import 'package:flutter/material.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});


  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  ThemeManager themeManager = locator<ThemeManager>();

  final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
     (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.wb_sunny);
    }
    return const Icon(Icons.nightlight_round);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: Theme.of(context).brightness == Brightness.light ? true : false,
      thumbIcon: thumbIcon,
      activeColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.lightColor4
          : Theme.of(context).colorScheme.darkColor4,
      onChanged: (bool value) {
        themeManager.inverseThemeMode();
      },
    );
  }
}
