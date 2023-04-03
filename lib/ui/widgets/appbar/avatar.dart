import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:rohy/ui/providers/home_screen.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: GestureDetector(
        onTap: () {},
        child: TextButton.icon(
          icon: FirebaseAuth.instance.currentUser == null
              ? const CircleAvatar(
                  child: Icon(
                    Icons.no_accounts_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                )
              : FirebaseAuth.instance.currentUser?.photoURL == null
                  ? const CircleAvatar()
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${FirebaseAuth.instance.currentUser?.photoURL}")),
          label: const Text("", style: TextStyle(fontSize: 10, color: Colors.white)),
          onPressed: () => {
            Provider.of<HomeScreenProvider>(context, listen: false).setIndex(2),
          },
        ),
      ),
    );
  }
}
