import 'dart:convert';
import 'package:http/http.dart' as http;

class MkAction {
  MkAction({
    required this.name,
    required this.description,
    this.reaction,
  });
  late String name;
  late String description;
  late MkReaction? reaction;
}

class MkReaction {
  late String name;
  late String description;
}

class ActionManager {
  List<MkAction> actions = <MkAction>[];
}
