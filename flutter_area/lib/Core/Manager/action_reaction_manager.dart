import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Utils/constants.dart';
import '../../Utils/mk_print.dart';
import '../Locator/locator.dart';
import 'user_manager.dart';

class MkActionReaction {
  MkActionReaction({
    required this.id,
    required this.name,
    required this.action,
    this.reaction,
    this.schedule,
  });
  late String id;
  late String name;
  late MkAction action;
  late MkReaction? reaction;
  late String? schedule;
}

enum ActionType {
  NASA_GET_APOD,
  WEATHER_GET_CURRENT,
  PULL_REQUEST_CREATED,
  ISSUE_OPENED,
  BRANCH_MERGED,
  PULL_REQUEST_REVIEW_REQUESTED,
  PULL_REQUEST_REVIEW_REQUEST_REMOVED,
  BRANCH_CREATED,
  BRANCH_DELETED,
  STAR_ADDED,
  STAR_REMOVED,
  NONE,
}

class MkAction {
  MkAction({
    required this.type,
  });
  factory MkAction.fromJson(Map<String, dynamic> json) {
    return MkAction(
      type: ActionType.values.firstWhere(
          (ActionType e) => e.name == json['actionType'] as String,
          orElse: () => ActionType.NONE),
    );
  }
  late ActionType type;
}

enum ReactionType {
  CREATE_DRAFT,
  NONE,
}

class MkReaction {
  MkReaction({
    required this.type,
  });
  factory MkReaction.fromJson(Map<String, dynamic> json) {
    return MkReaction(
      type: ReactionType.values.firstWhere(
          (ReactionType e) => e.name == json['reactionType'] as String,
          orElse: () => ReactionType.NONE),
    );
  }
  late ReactionType type;
}

class ActionReactionManager extends ChangeNotifier {
  List<MkActionReaction> actionsReactions = <MkActionReaction>[];

  Future getActionsReactions() async {
    try {
      final UserManager userManager = locator<UserManager>();
      final http.Response res = await http.get(
          Uri.parse('$kBaseUrl/action-reaction'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${userManager.accessToken}',
          });
      if (res.statusCode != 200) {
        return;
      }
      final List<dynamic> jsonBody = jsonDecode(res.body) as List<dynamic>;
      for (final dynamic actionReaction in jsonBody) {
        final String id = actionReaction['id'] as String;
        final String name = actionReaction['name'] as String;
        final Map<String, dynamic>? actionJson =
            actionReaction['action'] as Map<String, dynamic>?;
        if (actionJson == null) {
          continue;
        }
        final Map<String, dynamic>? reaction =
            actionReaction['reaction'] as Map<String, dynamic>?;
        final String? schedule = actionReaction['schedule'] as String?;
        actionsReactions.add(MkActionReaction(
          id: id,
          name: name,
          action: MkAction.fromJson(actionJson),
          reaction: reaction != null ? MkReaction.fromJson(reaction) : null,
          schedule: schedule,
        ));
      }
    } catch (e) {
      mkPrint('Error: $e');
    }
  }

  void addLocalActionForm(String name, ActionType type) {
    actionsReactions.add(MkActionReaction(
      id: 'local',
      name: name,
      action: MkAction(type: type),
    ));
    notifyListeners();
  }

  Future<bool> addAction(ActionType actionType, String name,
      Map<String, String> body, int localIndex) async {
    try {
      final UserManager userManager = locator<UserManager>();

      // Create ActionReaction
      final http.Response res =
          await http.post(Uri.parse('$kBaseUrl/action-reaction'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${userManager.accessToken}',
              },
              body: jsonEncode(<String, String>{'name': name}));
      if (res.statusCode != 201) {
        return false;
      }

      // Create Action
      final String id = jsonDecode(res.body)['id'] as String;
      final http.Response res2 =
          await http.post(Uri.parse('$kBaseUrl/action-reaction/$id/action'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${userManager.accessToken}',
              },
              body: jsonEncode(body));
      if (res2.statusCode != 201) {
        return false;
      }

      // Update local list
      actionsReactions[localIndex].id = id;
      actionsReactions[localIndex].name = name;
      actionsReactions[localIndex].action = MkAction(type: actionType);
      notifyListeners();
      return true;
    } catch (e) {
      mkPrint('Error: $e');
      return false;
    }
  }

  Future<bool> setReaction(String actionReactionId, ReactionType type,
      Map<String, String> body) async {
    try {
      final UserManager userManager = locator<UserManager>();
      final http.Response res = await http.post(
          Uri.parse('$kBaseUrl/action-reaction/$actionReactionId/reaction'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${userManager.accessToken}',
          },
          body: jsonEncode(body));
      if (res.statusCode != 201) {
        return false;
      }
      final int index = actionsReactions.indexWhere(
          (MkActionReaction element) => element.id == actionReactionId);
      actionsReactions[index].reaction = MkReaction(type: type);
      notifyListeners();
      return true;
    } catch (e) {
      mkPrint('Error: $e');
      return false;
    }
  }

  void removeReactionLocally(String actionReactionId) {
    final int index = actionsReactions.indexWhere(
        (MkActionReaction element) => element.id == actionReactionId);
    actionsReactions[index].reaction = null;
    notifyListeners();
  }
}
