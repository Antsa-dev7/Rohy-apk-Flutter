import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/providers/home_screen.dart';
import 'package:rohy/ui/providers/user_provider.dart';
import 'package:rohy/ui/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const RohyApp()));

}

class RohyApp extends StatelessWidget {
  const RohyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSwatch().copyWith(primary: quaternaryColor),
      ),
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: const HomeScreen(),
        styleTextUnderTheLoader: const TextStyle(),
        imageBackground: const AssetImage(backgroundImageUrl),
        photoSize: 100.0,
        loaderColor: tertiaryColor,
      ),
    );
  }
}

