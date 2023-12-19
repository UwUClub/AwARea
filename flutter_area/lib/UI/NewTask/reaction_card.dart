import 'package:flutter/material.dart';

import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import 'reaction_selection.dart';

class ReactionCard extends StatefulWidget {
  const ReactionCard({super.key, this.reaction, required this.setReaction});

  final MkReaction? reaction;
  final void Function(MkReaction?) setReaction;

  @override
  State<ReactionCard> createState() => _ReactionCardState();
}

class _ReactionCardState extends State<ReactionCard> {
  void setReaction(MkReaction? reaction) {
    setState(() {
      widget.setReaction(reaction);
    });
  }

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
      child: widget.reaction == null
          ? ReactionSelection(
              label: 'Google',
              reactions: <MkReaction>[
                MkReaction(
                    service: 'Gmail',
                    name: 'Send a mail',
                    description: 'description'),
                MkReaction(
                    service: 'Drive',
                    name: 'Upload a file',
                    description: 'description'),
              ],
              setReaction: setReaction,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Reaction ${widget.reaction!.service}',
                        style: Theme.of(context).textTheme.headlineLarge,
                        softWrap: false,
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          widget.setReaction(null);
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.lightColor4,
                  ),
                  Text(widget.reaction!.name,
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(widget.reaction!.description,
                      style: Theme.of(context).textTheme.headlineSmall),
                ]),
    );
  }
}
