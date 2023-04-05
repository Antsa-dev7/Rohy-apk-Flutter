import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier{
  int _index  = 0;
  int get index => _index;

  void setIndex(int index) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _index = index;
      notifyListeners();
    });
  }
}