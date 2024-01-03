import 'package:flutter/material.dart';

class MkActionReaction {
  MkActionReaction({
    required this.action,
    this.reaction,
    required this.name,
    this.schedule,
  });
  late MkAction action;
  late MkReaction? reaction;
  late String name;
  late String? schedule;
}

enum ActionType {
  NASA_GET_APOD,
  WEATHER_GET_CURRENT,
  CLOCK_GET_REGULAR,
}

class MkAction {
  MkAction({
    required this.type,
  });
  late ActionType type;
}

enum ReactionType {
  CREATE_DRAFT,
}

class MkReaction {
  MkReaction({
    required this.type,
  });
  late ReactionType type;
}

class ActionReactionManager extends ChangeNotifier {
  List<MkActionReaction> actionsReactions = <MkActionReaction>[];

  void addAction(String name, ActionType actionType) {
    actionsReactions.add(MkActionReaction(
      action: MkAction(type: actionType),
      name: name,
    ));
    notifyListeners();
  }
}
