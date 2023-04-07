import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/providers/user_interaction_provider.dart';
import 'package:rohy/ui/providers/user_provider.dart';
import 'package:rohy/ui/screens/authscreen.dart';
import 'package:rohy/ui/screens/home.dart';

class LoginLogoutButton extends StatelessWidget {
  const LoginLogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return TextButton.icon(
      onPressed: () async {
        if (user == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AuthScreen(),
              ),
                  (route) => false);
        }
        else {
          // Clear datas
          Provider.of<UserProvider>(context, listen: false).unSetUser();
          Provider.of<UserInteractionProvider>(context, listen: false).reset();
          await logout();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
                  (route) => false);
        }
      },
      icon: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Icon(
          user == null ? Icons.login : Icons.logout,
          size: 20,
        ),
      ),
      label: Text(user == null ? "Se connecter" : "Se déconnecter", style: bottomBarTabTitleStyle),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
