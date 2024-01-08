import 'package:flutter/material.dart';
import '../../../Core/Manager/action_reaction_manager.dart';
import '../../../Utils/Extensions/color_extensions.dart';
import '../../../Utils/Extensions/double_extensions.dart';
import '../../../Utils/constants.dart';

class ActionCard extends StatefulWidget {
  const ActionCard(
      {super.key,
      required this.actionReactionName,
      required this.action,
      required this.delete});

  final String actionReactionName;
  final MkAction action;
  final void Function() delete;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
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
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Action ${widget.actionReactionName}',
                    style: kIsPc
                        ? Theme.of(context).textTheme.headlineLarge
                        : Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.delete();
                  },
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.lightColor4,
            ),
            Text(widget.action.type.toString(),
                style: Theme.of(context).textTheme.headlineMedium),
            Text('Description',
                style: Theme.of(context).textTheme.headlineSmall),
          ]),
    );
  }
}
