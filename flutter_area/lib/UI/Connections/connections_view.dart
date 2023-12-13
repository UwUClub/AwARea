import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import '../ReusableWidgets/mk_button.dart';

class ConnectionsView extends StatefulWidget {
  const ConnectionsView({super.key});

  @override
  State<ConnectionsView> createState() => _ConnectionsViewState();
}

class _ConnectionsViewState extends State<ConnectionsView> {
  ThemeManager themeManager = locator<ThemeManager>();

  @override
  Widget build(BuildContext context) {
    return MkBackground(
      child: Padding(
          padding: EdgeInsets.only(
            top: 45.0.ratioH(),
            left: 137.0.ratioW(),
            right: 137.0.ratioW(),
            bottom: 36.0.ratioH()),
            child: Column(
              children: [
                Row(children: [
                  Text(AppLocalizations.of(context)!.connection, style: Theme.of(context).textTheme.titleMedium)
                  ]),
                const Divider(
                    endIndent: 0,
                    indent: 0,
                  ),
                Row(children: [
                  SvgPicture.asset('../../../assets/images/github.svg',
                  semanticsLabel: 'Logo',
                  width: 20.0.ratioW(),
                  height: 20.0.ratioH(),
                  ),
                  Text(AppLocalizations.of(context)!.github, style: Theme.of(context).textTheme.labelLarge)
                  ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.connectGithub, style: Theme.of(context).textTheme.labelMedium),
                    MkButton(label: AppLocalizations.of(context)!.connect, onPressed: () {},),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
