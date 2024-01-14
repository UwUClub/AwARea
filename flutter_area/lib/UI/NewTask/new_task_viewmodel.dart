import 'package:flutter/material.dart';

class NewTaskViewModel with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
