import 'package:flutter/material.dart';
import 'package:rohy/constants.dart';

class GoHomeButton extends StatelessWidget {
  const GoHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print("Go Home pressed");
      },
      icon: Image.asset("assets/icons/home_icon_full.png"),
      label: const Text("Accueil", style: bottomBarTabTitleStyle),
    );
  }
}
