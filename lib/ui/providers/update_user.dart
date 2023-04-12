import 'package:flutter/material.dart';

class ScreenUpdateUser extends ChangeNotifier {
  late String selectedWidget;

  get getSelectedScreen {
    return selectedWidget;
  }

  setSelectedScreen(String screen) {
    this.selectedWidget = screen;
    notifyListeners();
    return selectedWidget;

  }
}
