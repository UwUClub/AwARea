import 'package:flutter/material.dart';

import '../../../Core/Manager/action_reaction_manager.dart';
import '../../../Utils/Extensions/color_extensions.dart';

import '../../ReusableWidgets/mk_button.dart';

class ActionSelection extends StatelessWidget {
  const ActionSelection(
      {super.key,
      required this.label,
      required this.actionTypes,
      required this.addAction});

  final String label;
  final List<ActionType>? actionTypes;
  final void Function(ActionType) addAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: <Widget>[
      Text(label, style: Theme.of(context).textTheme.headlineMedium),
      for (final ActionType actionType in actionTypes!)
        Row(
          children: <Widget>[
            MkButton(
              label: actionType.toString(),
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.lightColor3
                  : Theme.of(context).colorScheme.darkColor3,
              labelColor: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.darkTransColor2
                  : Theme.of(context).colorScheme.lightTransColor2,
              onPressed: () {
                addAction(actionType);
              },
            ),
          ],
        ),
    ]));
  }
}
