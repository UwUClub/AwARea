import 'package:flutter/material.dart';
import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import 'action_selection.dart';
import 'task_card.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  List<MkAction> actions = <MkAction>[];

  void addAction(MkAction action) {
    setState(() {
      actions.add(action);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: Row(
        children: <Widget>[
          for (final MkAction action in actions)
            TaskCard(
                action: action,
                delete: () {
                  setState(() {
                    actions.remove(action);
                  });
                }),
        ],
      )),
      Container(
          padding: EdgeInsets.all(30.0.ratioW()),
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.lightColor2
                  : Theme.of(context).colorScheme.darkColor2),
          child: Column(
            children: <Widget>[
              ActionSelection(
                label: 'Météo',
                actions: <MkAction>[
                  MkAction(name: 'Get meteo', description: 'toto'),
                ],
                addAction: addAction,
              ),
              ActionSelection(
                label: 'Clock',
                actions: <MkAction>[
                  MkAction(name: 'Every n minutes', description: 'toto'),
                ],
                addAction: addAction,
              ),
            ],
          ))
    ]);
  }
}
