import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String name = "User";
  int points = 0;

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void addPoints(int value) {
    points += value;
    notifyListeners();
  }
}