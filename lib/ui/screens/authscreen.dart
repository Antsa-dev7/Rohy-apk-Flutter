import 'package:flutter/material.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/screens/home.dart';
import 'package:rohy/ui/widgets/auth/emaillogin.dart';
import 'package:rohy/ui/widgets/auth/fb.dart';
import 'package:rohy/ui/widgets/auth/google.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: gradientColors,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Text("Connexion à Rohy", style: headerTitleStyleWhite),
                          const SizedBox(height: 25),
                          Card(
                            color: Colors.white.withOpacity(0.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const EmailAuthWidget(),
                          ),
                          const SizedBox(height: 15),
                          const GoogleAuthWidget(),
                          const SizedBox(height: 15),
                          const FacebookAuthWidget(),
                          const SizedBox(height: 15),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                        (route) => false);
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
                                child: const Icon(
                                  Icons.home,
                                  size: 20,
                                ),
                              ),
                              label: Text("Retour à l'accueil", style: bottomBarTabTitleStyle,)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
