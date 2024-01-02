import 'package:flutter/material.dart';

import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import 'Components/action_card.dart';
import 'Components/action_selection.dart';
import 'Components/reaction_card.dart';

class NewTaskMobileView extends StatefulWidget {
  const NewTaskMobileView({super.key});

  @override
  State<NewTaskMobileView> createState() => _NewTaskMobileViewState();
}

class _NewTaskMobileViewState extends State<NewTaskMobileView> {
  List<MkAction> actions = <MkAction>[];

  void addAction(MkAction action) {
    setState(() {
      actions.add(action);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MkBackground(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(20.0.ratioW()),
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
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.ratioW()),
              child: Column(
                children: <Widget>[
                  for (final MkAction action in actions)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
          ]),
        ),
      ),
    );
  }
}
