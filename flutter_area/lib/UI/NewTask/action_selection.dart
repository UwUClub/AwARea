import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/action_manager.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';

import '../ReusableWidgets/mk_button.dart';
import '../Settings/settings_view.dart';

class ActionSelection extends StatelessWidget {
  const ActionSelection(
      {super.key,
      required this.label,
      this.actions,
      this.reactions,
      required this.addAction});

  final String label;
  final List<MkAction>? actions;
  final List<MkReaction>? reactions;
  final Function(MkAction) addAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 240.0.ratioW(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: Theme.of(context).textTheme.headlineMedium),
              for (final MkAction action in actions!)
                Row(
                  children: <Widget>[
                    MkButton(
                      label: action.name,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).colorScheme.lightColor3
                              : Theme.of(context).colorScheme.darkColor3,
                      labelColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).colorScheme.darkTransColor2
                              : Theme.of(context).colorScheme.lightTransColor2,
                      onPressed: () {
                        addAction(action);
                      },
                    ),
                  ],
                ),
            ]));
  }
}
