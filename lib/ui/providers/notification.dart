import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rohy/application/use_cases/search_post.dart';

class NotificationProvider extends ChangeNotifier{
  int _count  = 10;
  int get count => _count;

  void setCount(int count) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _count = count;
      notifyListeners();
    });
  }

  void search(){
    SearchPostUseCase useCase = SearchPostUseCase();
    useCase.execute("");
    _count = Random().nextInt(1000);
    notifyListeners();
  }
}