import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/action_reaction_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import 'Components/action_card.dart';
import 'Components/action_selection_list.dart';
import 'Components/reaction_card.dart';
import 'new_task_viewmodel.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  ActionReactionManager actionReactionManager =
      locator<ActionReactionManager>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NewTaskViewModel(),
      builder: (BuildContext context, Widget? child) {
        return Consumer<NewTaskViewModel>(
          builder: (BuildContext context, NewTaskViewModel vm, Widget? child) {
            actionReactionManager.newTaskViewModel = vm;
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
                              in actionReactionManager.actionsReactions)
                            Row(children: <Widget>[
                              ActionCard(
                                actionReaction: actionReaction,
                              ),
                              ReactionCard(
                                actionReaction: actionReaction,
                              ),
                            ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(30.0.ratioW()),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.lightColor2
                                  : Theme.of(context).colorScheme.darkColor2),
                      child: const ActionSelectionList()),
                )
              ]),
            );
          },
        );
      },
    );
  }
}
