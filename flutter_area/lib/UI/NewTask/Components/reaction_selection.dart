import 'package:flutter/material.dart';

import '../../../Core/Manager/action_reaction_manager.dart';
import '../../../Utils/Extensions/color_extensions.dart';
import '../../../Utils/Extensions/double_extensions.dart';

import '../../ReusableWidgets/mk_button.dart';

class ReactionSelection extends StatelessWidget {
  const ReactionSelection(
      {super.key,
      required this.label,
      this.reactionTypes,
      required this.setReaction});

  final String label;
  final List<ReactionType>? reactionTypes;
  final void Function(ReactionType) setReaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 240.0.ratioW(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: Theme.of(context).textTheme.headlineMedium),
              for (final ReactionType reactionType in reactionTypes!)
                Row(
                  children: <Widget>[
                    MkButton(
                      label: reactionType.label,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).colorScheme.lightColor3
                              : Theme.of(context).colorScheme.darkColor3,
                      labelColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).colorScheme.darkTransColor2
                              : Theme.of(context).colorScheme.lightTransColor2,
                      onPressed: () {
                        setReaction(reactionType);
                      },
                    ),
                  ],
                ),
            ]));
  }
}
