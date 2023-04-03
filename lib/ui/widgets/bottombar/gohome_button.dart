import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/providers/home_screen.dart';

class GoHomeButton extends StatelessWidget {
  const GoHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Provider.of<HomeScreenProvider>(context, listen: false).setIndex(0);
      },
      icon: Image.asset("assets/icons/home_icon_full.png"),
      label: const Text("Accueil", style: bottomBarTabTitleStyle),
    );
  }
}
