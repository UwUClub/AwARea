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

  Future<bool> addAction(String name, ActionType actionType) async {
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
      final http.Response res2 = await http.post(
          Uri.parse('$kBaseUrl/action-reaction/$id/action'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${userManager.accessToken}',
          },
          body: jsonEncode(<String, String>{
            'actionType': actionType.name,
            'location': 'Paris'
          }));
      if (res2.statusCode != 201) {
        return false;
      }

      // Update local list
      actionsReactions.add(MkActionReaction(
        id: id,
        name: name,
        action: MkAction(type: actionType),
      ));
      notifyListeners();
      return true;
    } catch (e) {
      mkPrint('Error: $e');
      return false;
    }
  }
}
