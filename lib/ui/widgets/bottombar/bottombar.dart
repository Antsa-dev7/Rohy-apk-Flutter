import 'package:flutter/material.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/widgets/bottombar/gohome_button.dart';
import 'package:rohy/ui/widgets/bottombar/login_logout_button.dart';
import 'package:rohy/ui/widgets/bottombar/post_button.dart';


class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: quinaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          GoHomeButton(),
          PostButton(),
          LoginLogoutButton()
        ]),
    );
  }
}
