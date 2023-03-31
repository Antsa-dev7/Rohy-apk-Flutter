import 'package:firebase_auth/firebase_auth.dart';

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
}
