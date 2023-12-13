import 'package:flutter/material.dart';
import '../../Core/Manager/action_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';

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
    return Container(
      margin: EdgeInsets.all(10.0.ratioW()),
      padding: EdgeInsets.all(20.0.ratioW()),
      decoration: const BoxDecoration(color: Colors.red),
      width: 312.0.ratioW(),
      height: 138.0.ratioH(),
      child: Column(children: <Widget>[
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
        Text('test ${widget.action.description}'),
      ]),
    );
  }
}
