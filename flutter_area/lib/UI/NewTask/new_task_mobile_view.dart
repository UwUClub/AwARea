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

class NewTaskMobileView extends StatefulWidget {
  const NewTaskMobileView({super.key});

  @override
  State<NewTaskMobileView> createState() => _NewTaskMobileViewState();
}

class _NewTaskMobileViewState extends State<NewTaskMobileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => locator<ActionReactionManager>(),
      builder: (BuildContext context, Widget? child) {
        return Consumer<ActionReactionManager>(
          builder: (BuildContext context, ActionReactionManager manager,
              Widget? child) {
            return SafeArea(
              child: MkBackground(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(20.0.ratioW()),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.ratioW()),
                      child: Column(
                        children: <Widget>[
                          for (final MkActionReaction actionReaction
                              in manager.actionsReactions)
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ActionCard(
                                      actionReactionName: actionReaction.name,
                                      action: actionReaction.action,
                                      delete: () {}),
                                  ReactionCard(
                                    reaction: actionReaction.reaction,
                                    setReaction:
                                        (ReactionType? reactionType) {},
                                  ),
                                ]),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
