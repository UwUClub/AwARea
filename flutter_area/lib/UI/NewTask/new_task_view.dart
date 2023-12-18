import 'package:flutter/material.dart';
import '../../Core/Locator/locator.dart';
import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import 'action_selection.dart';
import 'action_card.dart';
import 'reaction_card.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  List<MkAction> actions = <MkAction>[];

  @override
  void initState() {
    super.initState();
    setState(() {
      actions = locator<ActionManager>().actions;
    });
  }

  void addAction(MkAction action) {
    setState(() {
      actions.add(action);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MkBackground(
      child: Row(children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(70.0.ratioW()),
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: <Widget>[
                  for (final MkAction action in actions)
                    Row(children: <Widget>[
                      ActionCard(
                          action: action,
                          delete: () {
                            setState(() {
                              actions.remove(action);
                            });
                          }),
                      ReactionCard(
                        reaction: action.reaction,
                        setReaction: (MkReaction? reaction) {
                          setState(() {
                            action.reaction = reaction;
                          });
                        },
                      ),
                    ]),
                ],
              ),
            ),
          ),
        ),
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
                    MkAction(
                        service: 'Weather',
                        name: 'Get meteo',
                        description: 'toto'),
                  ],
                  addAction: addAction,
                ),
                ActionSelection(
                  label: 'Clock',
                  actions: <MkAction>[
                    MkAction(
                        service: 'Clock',
                        name: 'Every n minutes',
                        description: 'toto'),
                  ],
                  addAction: addAction,
                ),
              ],
            ))
      ]),
    );
  }
}
