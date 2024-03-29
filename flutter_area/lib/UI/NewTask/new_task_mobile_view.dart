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

class NewTaskMobileView extends StatefulWidget {
  const NewTaskMobileView({super.key});

  @override
  State<NewTaskMobileView> createState() => _NewTaskMobileViewState();
}

class _NewTaskMobileViewState extends State<NewTaskMobileView> {
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
                        child: const ActionSelectionList()),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.ratioW()),
                      child: Column(
                        children: <Widget>[
                          for (final MkActionReaction actionReaction
                              in actionReactionManager.actionsReactions)
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
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
