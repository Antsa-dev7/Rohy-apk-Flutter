// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:rohy/domain/user/user.dart';

class UserProvider extends ChangeNotifier {
  RohyUser? _user;

  RohyUser? get user {
    return _user;
  }

  void setUser(RohyUser user, String from) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _user = user;
      notifyListeners();
    });
  }

  void unSetUser() {
    _user = null;
  }
}
