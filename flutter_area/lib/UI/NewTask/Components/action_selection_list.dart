import 'package:flutter/material.dart';

import '../../../Core/Manager/action_reaction_manager.dart';
import 'action_selection.dart';

class ActionSelectionList extends StatefulWidget {
  const ActionSelectionList({super.key});

  @override
  State<ActionSelectionList> createState() => _ActionSelectionListState();
}

class _ActionSelectionListState extends State<ActionSelectionList> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        ActionSelection(
          label: 'Horloge',
          actionTypes: <ActionType>[
            ActionType.TIMER,
          ],
        ),
        ActionSelection(
          label: 'Météo',
          actionTypes: <ActionType>[
            ActionType.WEATHER_GET_CURRENT,
          ],
        ),
        ActionSelection(
          label: 'Nasa',
          actionTypes: <ActionType>[
            ActionType.NASA_GET_APOD,
          ],
        ),
        ActionSelection(
          label: 'Github',
          actionTypes: <ActionType>[
            ActionType.PULL_REQUEST_CREATED,
            ActionType.ISSUE_OPENED,
            ActionType.BRANCH_MERGED,
            ActionType.PULL_REQUEST_REVIEW_REQUESTED,
            ActionType.PULL_REQUEST_REVIEW_REQUEST_REMOVED,
            ActionType.BRANCH_CREATED,
            ActionType.BRANCH_DELETED,
            ActionType.STAR_ADDED,
            ActionType.STAR_REMOVED
          ],
        ),
      ],
    );
  }
}
