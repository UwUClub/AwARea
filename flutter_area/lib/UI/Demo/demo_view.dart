import 'package:flutter/material.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../ReusableWidgets/mk_background.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  ThemeManager themeManager = locator<ThemeManager>();

  @override
  Widget build(BuildContext context) {
    return MkBackground(
      child: Center(
          child: Column(
        children: <Widget>[
          Text('OUI!', style: Theme.of(context).textTheme.titleLarge),
          ElevatedButton(
              onPressed: () => themeManager.inverseThemeMode(),
              child: Center(
                  child: Text('Inverse',
                      style: Theme.of(context).textTheme.labelLarge)))
        ],
      )),
    );
  }
}
