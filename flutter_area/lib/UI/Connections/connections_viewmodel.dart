import 'package:flutter/material.dart';

class ConnectionsViewModel with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
