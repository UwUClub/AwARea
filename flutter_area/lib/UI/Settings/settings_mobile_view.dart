import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import '../ReusableWidgets/mk_switch.dart';

class SettingsMobileView extends StatefulWidget {
  const SettingsMobileView({super.key});

  @override
  State<SettingsMobileView> createState() => _SettingsMobileViewState();
}

class _SettingsMobileViewState extends State<SettingsMobileView> {
  ThemeManager themeManager = locator<ThemeManager>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MkBackground(
          child: Padding(
        padding: EdgeInsets.only(
            top: 45.0.ratioH(),
            left: 37.0.ratioW(),
            right: 37.0.ratioW(),
            bottom: 36.0.ratioH()),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text(AppLocalizations.of(context)!.mySettings,
                  style: Theme.of(context).textTheme.titleMedium)
            ]),
            const Divider(
              endIndent: 0,
              indent: 0,
            ),
            Row(children: <Widget>[
              Text(AppLocalizations.of(context)!.appearance,
                  style: Theme.of(context).textTheme.labelLarge)
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.changeAppearance,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(width: 10.0.ratioW()),
                const SwitchExample(),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
