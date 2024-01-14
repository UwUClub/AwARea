import 'package:flutter/material.dart';
import '../../../Core/Locator/locator.dart';
import '../../../Core/Manager/action_reaction_manager.dart';
import '../../../Utils/Extensions/color_extensions.dart';
import '../../../Utils/Extensions/double_extensions.dart';
import '../../../Utils/constants.dart';
import 'action_form.dart';

class ActionCard extends StatefulWidget {
  const ActionCard({super.key, required this.actionReaction});

  final MkActionReaction actionReaction;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  ActionReactionManager manager = locator<ActionReactionManager>();

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
                Text('Action ${widget.actionReaction.name}',
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
                    manager.deleteActionReaction(widget.actionReaction.id);
                  },
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.lightColor4,
            ),
            if (widget.actionReaction.id == 'local')
              ActionForm(
                actionReaction: widget.actionReaction,
                onSubmit: (Map<String, String> data) => <Future<bool>>{
                  manager.addAction(
                      widget.actionReaction.action.type,
                      widget.actionReaction.name,
                      data,
                      manager.actionsReactions.indexOf(widget.actionReaction))
                },
              )
            else
              Column(children: <Widget>[
                Text(widget.actionReaction.action.type.label,
                    style: Theme.of(context).textTheme.headlineMedium),
              ]),
          ]),
    );
  }
}
