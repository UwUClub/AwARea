import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/slack_manager.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import '../ReusableWidgets/mk_button.dart';
import '../ReusableWidgets/mk_input.dart';

class ConnectionsView extends StatefulWidget {
  const ConnectionsView({super.key});

  @override
  State<ConnectionsView> createState() => _ConnectionsViewState();
}

class _ConnectionsViewState extends State<ConnectionsView> {
  ThemeManager themeManager = locator<ThemeManager>();
  SlackManager slackManager = locator<SlackManager>();

  String slackBotTokenInput = '';

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
          children: <Widget>[
            Row(children: <Widget>[
              Text(AppLocalizations.of(context)!.connection,
                  style: Theme.of(context).textTheme.titleMedium)
            ]),
            const Divider(
              endIndent: 0,
              indent: 0,
            ),
            Row(children: <Widget>[
              const Icon(FontAwesomeIcons.github, size: 20),
              Text(AppLocalizations.of(context)!.github,
                  style: Theme.of(context).textTheme.labelLarge)
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(AppLocalizations.of(context)!.connectGithub,
                    style: Theme.of(context).textTheme.labelMedium),
                MkButton(
                  label: AppLocalizations.of(context)!.connect,
                  onPressed: () {},
                ),
              ],
            ),
            Row(children: <Widget>[
              const Icon(FontAwesomeIcons.google, size: 20),
              Text(AppLocalizations.of(context)!.google,
                  style: Theme.of(context).textTheme.labelLarge)
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(AppLocalizations.of(context)!.connectGoogle,
                    style: Theme.of(context).textTheme.labelMedium),
                MkButton(
                  label: AppLocalizations.of(context)!.connect,
                  onPressed: () {},
                ),
              ],
            ),
            Row(children: <Widget>[
              const Icon(FontAwesomeIcons.slack, size: 20),
              Text(AppLocalizations.of(context)!.slack,
                  style: Theme.of(context).textTheme.labelLarge)
            ]),
            SizedBox(height: 10.0.ratioH()),
            Row(children: <Widget>[
              Text(AppLocalizations.of(context)!.connectSlack,
                  style: Theme.of(context).textTheme.labelMedium)
            ]),
            SizedBox(height: 10.0.ratioH()),
            MkInput(
              placeholder: 'xxxx-...',
              onChanged: (String value) {
                setState(() {
                  slackBotTokenInput = value;
                });
              },
            ),
            SizedBox(height: 10.0.ratioH()),
            Row(
              children: <Widget>[
                MkButton(
                  label: AppLocalizations.of(context)!.validate,
                  onPressed: () {
                    SlackManager().updateBotToken(slackBotTokenInput);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
