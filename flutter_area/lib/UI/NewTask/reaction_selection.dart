import 'package:flutter/material.dart';

import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

import '../ReusableWidgets/mk_button.dart';

class ReactionSelection extends StatelessWidget {
  const ReactionSelection(
      {super.key,
      required this.label,
      this.reactions,
      required this.setReaction});

  final String label;
  final List<MkReaction>? reactions;
  final void Function(MkReaction) setReaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 240.0.ratioW(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: Theme.of(context).textTheme.headlineMedium),
              for (final MkReaction reaction in reactions!)
                Row(
                  children: <Widget>[
                    MkButton(
                      label: reaction.name,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).colorScheme.lightColor3
                              : Theme.of(context).colorScheme.darkColor3,
                      labelColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).colorScheme.darkTransColor2
                              : Theme.of(context).colorScheme.lightTransColor2,
                      onPressed: () {
                        setReaction(reaction);
                      },
                    ),
                  ],
                ),
            ]));
  }
}
