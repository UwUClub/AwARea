import 'package:flutter/material.dart';

import '../../../Core/Manager/action_reaction_manager.dart';
import '../../../Utils/Extensions/color_extensions.dart';
import '../../../Utils/Extensions/double_extensions.dart';
import '../../../Utils/constants.dart';
import 'reaction_form.dart';
import 'reaction_selection.dart';

class ReactionCard extends StatefulWidget {
  const ReactionCard(
      {super.key, required this.actionReaction, required this.manager});

  final MkActionReaction actionReaction;
  final ActionReactionManager manager;

  @override
  State<ReactionCard> createState() => _ReactionCardState();
}

class _ReactionCardState extends State<ReactionCard> {
  ReactionType? creatingReaction;

  void setReaction(ReactionType type, Map<String, String> data) {
    widget.manager.setReaction(
      widget.actionReaction.id,
      type,
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kIsPc
          ? EdgeInsets.all(10.0.ratioW())
          : EdgeInsets.only(top: 20.0.ratioW()),
      padding: kIsPc ? EdgeInsets.all(20.0.ratioW()) : null,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).colorScheme.lightColor2
              : Theme.of(context).colorScheme.darkColor2),
      width: kIsPc ? 312.0.ratioW() : 165.0.ratioW(),
      height: kIsPc ? 138.0.ratioH() : 400.0.ratioH(),
      child: widget.actionReaction.reaction == null
          ? (creatingReaction == null
              ? ReactionSelection(
                  label: 'Google',
                  reactionTypes: const <ReactionType>[
                    ReactionType.CREATE_DRAFT,
                  ],
                  setReaction: (ReactionType type) {
                    setState(() {
                      creatingReaction = type;
                    });
                  })
              : ReactionForm(
                  reactionType: creatingReaction!,
                  onSubmit: (Map<String, String> data) =>
                      <void>{setReaction(creatingReaction!, data)}))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Reaction',
                        style: kIsPc
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                        softWrap: false,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          widget.manager
                              .removeReactionLocally(widget.actionReaction.id);
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.lightColor4,
                  ),
                  Text(widget.actionReaction.reaction!.type.toString(),
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text('Description',
                      style: Theme.of(context).textTheme.headlineSmall),
                ]),
    );
  }
}
