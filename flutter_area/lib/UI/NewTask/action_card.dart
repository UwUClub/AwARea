import 'package:flutter/material.dart';
import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class ActionCard extends StatefulWidget {
  const ActionCard({super.key, required this.action, required this.delete});

  final MkAction action;
  final void Function() delete;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0.ratioW()),
      padding: EdgeInsets.all(20.0.ratioW()),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).colorScheme.lightColor2
              : Theme.of(context).colorScheme.darkColor2),
      width: 312.0.ratioW(),
      height: 138.0.ratioH(),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Action ${widget.action.service}',
                    style: Theme.of(context).textTheme.headlineLarge),
                const Expanded(child: SizedBox()),
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
            Text(widget.action.name,
                style: Theme.of(context).textTheme.headlineMedium),
            Text(widget.action.description,
                style: Theme.of(context).textTheme.headlineSmall),
          ]),
    );
  }
}
