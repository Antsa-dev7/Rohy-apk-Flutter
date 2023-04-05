import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseSignInByGoogle {
  final FirebaseAuth _auth;

  FirebaseSignInByGoogle(this._auth);

  // login with email function
  Future<bool?> signIn() async {
    UserCredential? authResult;
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        /// Sign in with Google
        authResult = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          /// Sign with Google
          authResult = await _auth.signInWithCredential(credential);
        }
      }
      final googleUser = FirebaseAuth.instance.currentUser;
      return googleUser != null;

    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
}
