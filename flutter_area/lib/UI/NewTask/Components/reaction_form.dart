import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Core/Manager/action_reaction_manager.dart';

class ReactionForm extends StatefulWidget {
  const ReactionForm(
      {super.key, required this.reactionType, required this.onSubmit});

  final ReactionType reactionType;
  final void Function(Map<String, String>) onSubmit;

  @override
  State<ReactionForm> createState() => _ReactionFormState();
}

class _ReactionFormState extends State<ReactionForm> {
  List<String> fieldLabels = <String>[];
  List<String> fieldValues = <String>[];

  @override
  void initState() {
    super.initState();
    switch (widget.reactionType) {
      case ReactionType.CREATE_DRAFT:
        fieldLabels = <String>['destinationEmail', 'subject', 'body'];
      case ReactionType.SEND_SLACK_MESSAGE:
        fieldLabels = <String>['channelName', 'message'];
      case ReactionType.CREATE_SLACK_CHANNEL:
        fieldLabels = <String>['channelName'];
      case ReactionType.SEND_EMAIL:
        fieldLabels = <String>['destinationEmail', 'subject', 'body'];
      case ReactionType.NONE:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (int i = 0; i < fieldLabels.length; i++)
          TextFormField(
            style: const TextStyle(fontSize: 12),
            onChanged: (String value) {
              fieldValues[i] = value;
            },
            decoration: InputDecoration(
              labelText: fieldLabels[i],
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ElevatedButton(
          onPressed: () {
            final Map<String, String> data = <String, String>{};
            for (int i = 0; i < fieldLabels.length; i++) {
              data[fieldLabels[i]] = fieldValues[i];
            }
            data['reactionType'] = widget.reactionType.name;
            widget.onSubmit(data);
          },
          child: Text(AppLocalizations.of(context)!.createReaction),
        ),
      ],
    );
  }
}
