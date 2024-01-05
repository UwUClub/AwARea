import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/action_reaction_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import 'Components/action_card.dart';
import 'Components/action_selection.dart';
import 'Components/reaction_card.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => locator<ActionReactionManager>(),
      builder: (BuildContext context, Widget? child) {
        return Consumer<ActionReactionManager>(
          builder: (BuildContext context, ActionReactionManager manager,
              Widget? child) {
            return MkBackground(
              child: Row(children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(70.0.ratioW()),
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      child: Column(
                        children: <Widget>[
                          for (final MkActionReaction actionReaction
                              in manager.actionsReactions)
                            Row(children: <Widget>[
                              ActionCard(
                                actionReactionName: actionReaction.name,
                                action: actionReaction.action,
                                delete: () {
                                  // manager.deleteAction ...
                                },
                              ),
                              ReactionCard(
                                reaction: actionReaction.reaction,
                                setReaction: (ReactionType? reactionType,
                                    Map<String, String>? data) {
                                  if (reactionType == null || data == null) {
                                    manager.removeReactionLocally(
                                        actionReaction.id);
                                    return;
                                  }
                                  manager.setReaction(
                                    actionReaction.id,
                                    reactionType,
                                    data,
                                  );
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
                          actionTypes: const <ActionType>[
                            ActionType.WEATHER_GET_CURRENT,
                          ],
                          addAction: (String name, ActionType type) {
                            manager.addAction(name, type);
                          },
                        ),
                        ActionSelection(
                          label: 'Nasa',
                          actionTypes: const <ActionType>[
                            ActionType.NASA_GET_APOD,
                          ],
                          addAction: (String name, ActionType type) {
                            manager.addAction(name, type);
                          },
                        ),
                      ],
                    ))
              ]),
            );
          },
        );
      },
    );
  }
}
