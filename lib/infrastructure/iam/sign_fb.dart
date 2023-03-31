import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseSignInByFB {
  final FirebaseAuth _auth;

  FirebaseSignInByFB(this._auth);

  // login with email function
  Future<bool?> signIn() async {
    UserCredential? authResult;
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

      /// Sign in with Facebook
      authResult = await _auth.signInWithCredential(facebookAuthCredential);
      final fbuSer = FirebaseAuth.instance.currentUser;
      return fbuSer != null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
}
