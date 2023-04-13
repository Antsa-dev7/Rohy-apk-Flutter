import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthMethods {

  static Future updatePassword({
    required String password,
  }) async {
    Logger _logger = Logger();
    User user = FirebaseAuth.instance.currentUser!;
    user.updatePassword(password).then((_) {
      _logger.i("Successfully changed password");
    }).catchError((error) {
      _logger.i("Password can't be changed" + error.toString());
    });
  }
}