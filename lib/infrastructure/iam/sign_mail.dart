import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FirebaseSignInByMail {
  final FirebaseAuth _auth;

  FirebaseSignInByMail(this._auth);

  // login with email function
  Future<bool?> signIn(
      {required String email, required String password}) async {
    try {
      /// Sign in with email
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

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
