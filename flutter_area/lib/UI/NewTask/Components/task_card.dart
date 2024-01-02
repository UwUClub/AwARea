import 'package:flutter/material.dart';
import '../../../Core/Manager/action_manager.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.action, required this.delete});

  final MkAction action;
  final Function() delete;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Text(widget.action.name),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.delete();
            },
          ),
        ],
      ),
      Text(widget.action.description),
    ]);
  }
}
