import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rohy/ui/screens/user/user_profile.dart';
import '../../../constants.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Logger logger = Logger();
  User? user;
  bool isSocialLogin = false;
  String socialProvider = "";

  @override
  void initState() {
    super.initState();
    logger.i(">>initState");
    user = FirebaseAuth.instance.currentUser!;
    if (user != null) {
      logger.i("Provider : ${user?.providerData}");
      if (user?.providerData != null) {
        if (user?.providerData.first.providerId != 'password') {
          isSocialLogin = true;
          socialProvider = "${user?.providerData.first.providerId}";
        }
      }
    }
    logger.i("user: $user, $isSocialLogin");
    logger.i("<<initState");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    //Provider.of<ScreenProvider>(context, listen: false)
                    //.setEntepriseIndex(0, Enterprise.initEnterprise());
                  },
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "Informations personnelles",
                        style: tabTitleStyle,
                      ),
                    ),
                    Tab(
                        child: Text(
                          "Mes entreprises",
                          style: tabTitleStyle,
                        )),
                  ],
                ),
              ],
            )),
        body: TabBarView(
          children: [
            UserProfile(
                uid: "${user?.uid}",
                isSocialLogin: isSocialLogin,
                socialProvider: socialProvider),
            //EnterprisesScreen(),
          ],
        ),
      ),
    );
  }
}

