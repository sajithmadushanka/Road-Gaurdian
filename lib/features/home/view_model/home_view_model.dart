import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String userName = "John";

  void fetchUser() {
    // Normally fetched from API or local DB
    userName = "Alex";
    notifyListeners();
  }
}
