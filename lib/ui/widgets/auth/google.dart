import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rohy/application/use_cases/load_user.dart';
import 'package:rohy/application/use_cases/save_social_user.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/iam/sign_google.dart';
import 'package:rohy/ui/providers/user_provider.dart';
import 'package:rohy/ui/screens/home.dart';
import 'package:rohy/ui/widgets/custom_button.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () async {
        var success =
        await FirebaseSignInByGoogle(FirebaseAuth.instance)
            .signIn();
        if (success != null && success) {
          // Load User
          SaveSocialUserUseCase usecase = SaveSocialUserUseCase();
          RohyUser rohyUser = await usecase.execute(FirebaseAuth.instance.currentUser!);
          rohyUser = await LoadUserUseCase().execute(rohyUser.uid);
          Provider.of<UserProvider>(context, listen: false).setUser(rohyUser, "Authentication");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
                  (route) => false);
        }
      },
      imagePath: "assets/icons/google_icon.png",
      buttonText: "Connexion avec Google",
      imageWidth: 20,
      buttonColor: Colors.white,
      textColor: Colors.black,
    );
  }
}
