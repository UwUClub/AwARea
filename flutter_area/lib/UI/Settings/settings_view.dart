import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/constants.dart';
import '../ReusableWidgets/mk_background.dart';
import '../ReusableWidgets/mk_switch.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  ThemeManager themeManager = locator<ThemeManager>();

  @override
  Widget build(BuildContext context) {
    if (kIsPc) {
      return MkBackground(
        child: Padding(
          padding: EdgeInsets.only(
            top: 45.0.ratioH(),
            left: 137.0.ratioW(),
            right: 137.0.ratioW(),
            bottom: 36.0.ratioH()),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text(AppLocalizations.of(context)!.mySettings, style: Theme.of(context).textTheme.titleMedium)
                ]),
              const Divider(
                  endIndent: 0,
                  indent: 0,
                ),
              Row(children: <Widget>[
                Text(AppLocalizations.of(context)!.appearance, style: Theme.of(context).textTheme.labelLarge)
                ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.changeAppearance, style: Theme.of(context).textTheme.labelMedium),
                  const SwitchExample(),
                ],
              ),
            ],
          ),
        )
      );
    } else {
      return MkBackground(
        child: Padding(
          padding: EdgeInsets.only(
            top: 45.0.ratioH(),
            left: 137.0.ratioW(),
            right: 137.0.ratioW(),
            bottom: 36.0.ratioH()),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text(AppLocalizations.of(context)!.mySettings, style: Theme.of(context).textTheme.titleMedium)
                ]),
              const Divider(
                  endIndent: 0,
                  indent: 0,
                ),
              Row(children: <Widget>[
                Text(AppLocalizations.of(context)!.appearance, style: Theme.of(context).textTheme.labelLarge)
                ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.changeAppearance, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              const Row(
                children: <Widget>[
                  SwitchExample(),
                ],
              ),
            ],
          ),
        )
      );
    }
  }
}
