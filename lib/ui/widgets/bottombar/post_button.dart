import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/providers/home_screen.dart';

import '../../providers/notification.dart';

class PostButton extends StatelessWidget {
  const PostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Provider.of<HomeScreenProvider>(context, listen: false).setIndex(1);
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
          Icons.add,
          size: 20,
        ),
      ),
      label: const Text("Annonces", style: bottomBarTabTitleStyle),
    );
  }
}
