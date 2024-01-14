import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Core/Manager/action_reaction_manager.dart';

class ActionForm extends StatefulWidget {
  const ActionForm({
    super.key,
    required this.actionReaction,
    required this.onSubmit,
  });

  final MkActionReaction actionReaction;
  final void Function(Map<String, String>) onSubmit;

  @override
  State<ActionForm> createState() => _ActionFormState();
}

class _ActionFormState extends State<ActionForm> {
  List<String> fieldLabels = <String>[];
  List<String> fieldValues = <String>[];

  @override
  void initState() {
    super.initState();
    switch (widget.actionReaction.action.type) {
      case ActionType.NASA_GET_APOD:
        fieldLabels = <String>[];
      case ActionType.WEATHER_GET_CURRENT:
        fieldLabels = <String>['location'];
      case ActionType.TIMER:
        fieldLabels = <String>['date'];
      case ActionType.PULL_REQUEST_CREATED ||
            ActionType.ISSUE_OPENED ||
            ActionType.BRANCH_MERGED ||
            ActionType.PULL_REQUEST_REVIEW_REQUESTED ||
            ActionType.PULL_REQUEST_REVIEW_REQUEST_REMOVED ||
            ActionType.BRANCH_CREATED ||
            ActionType.BRANCH_DELETED ||
            ActionType.STAR_ADDED ||
            ActionType.STAR_REMOVED:
        fieldLabels = <String>['githubRepoName'];
      case ActionType.NONE:
        break;
    }
  }

  String convertDateFormat(String date) {
    final List<String> dateParts = date.split(' ');
    if (dateParts.length < 2) {
      return date;
    }
    final List<String> dateParts2 = dateParts[0].split('/');
    final String result =
        '${dateParts2[2]}-${dateParts2[1]}-${dateParts2[0]}T${dateParts[1]}.000Z';
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              hintText: fieldLabels[i] == 'date'
                  ? 'format: dd/mm/yyyy hh:mm:ss'
                  : null,
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
            data['actionType'] = widget.actionReaction.action.type.name;
            if (data['date'] != null) {
              data['date'] = convertDateFormat(data['date']!);
            }
            widget.onSubmit(data);
          },
          child: Text(AppLocalizations.of(context)!.createAction),
        ),
      ],
    );
  }
}
