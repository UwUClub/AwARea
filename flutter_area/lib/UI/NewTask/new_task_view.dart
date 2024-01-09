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
                                actionReaction: actionReaction,
                                manager: manager,
                              ),
                              ReactionCard(
                                actionReaction: actionReaction,
                                manager: manager,
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
                          manager: manager,
                        ),
                        ActionSelection(
                          label: 'Nasa',
                          actionTypes: const <ActionType>[
                            ActionType.NASA_GET_APOD,
                          ],
                          manager: manager,
                        ),
                        ActionSelection(
                          label: 'Github',
                          actionTypes: const <ActionType>[
                            ActionType.PULL_REQUEST_CREATED,
                            ActionType.ISSUE_OPENED,
                            ActionType.BRANCH_MERGED,
                            ActionType.PULL_REQUEST_REVIEW_REQUESTED,
                            ActionType.PULL_REQUEST_REVIEW_REQUEST_REMOVED,
                            ActionType.BRANCH_CREATED,
                            ActionType.BRANCH_DELETED,
                            ActionType.STAR_ADDED,
                            ActionType.STAR_REMOVED
                          ],
                          manager: manager,
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
