class MkAction {
  MkAction({
    required this.service,
    required this.name,
    required this.description,
    this.reaction,
  });
  late String service;
  late String name;
  late String description;
  late MkReaction? reaction;
}

class MkReaction {
  MkReaction({
    required this.service,
    required this.name,
    required this.description,
  });
  late String service;
  late String name;
  late String description;
}

class ActionManager {
  List<MkAction> actions = <MkAction>[];

  void addAction(MkAction action) {
    actions.add(action);
  }
}
