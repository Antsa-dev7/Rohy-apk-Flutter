import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rohy/infrastructure/iam/sign_fb.dart';
import 'package:rohy/ui/screens/home.dart';
import 'package:rohy/ui/widgets/custom_button.dart';

class FacebookAuthWidget extends StatelessWidget {
  const FacebookAuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () async {
        var success =
        await FirebaseSignInByFB(FirebaseAuth.instance)
            .signIn();
        if (success != null && success) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
                  (route) => false);
        }
      },
      imagePath: "assets/icons/facebook_icon.png",
      buttonText: "Connexion avec Facebook",
      imageWidth: 20,
      buttonColor: Colors.white,
      textColor: Colors.black,
    );
  }
}
