import 'package:flutter/material.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/widgets/appbar/avatar.dart';
import 'package:rohy/ui/widgets/appbar/logo.dart';
import 'package:rohy/ui/widgets/appbar/popupmenu.dart';
import 'package:rohy/ui/widgets/appbar/searchbar.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key})
      : super(
            titleSpacing: 10,
            title: const Text("Malagasy first !",
                style: nindoStyle),
            leading: Transform.translate(
              offset: Offset(15, 5),
              child: Builder(
                builder: (BuildContext context) {
                 return LogoWidget();
                },
              ),
            ),
            actions: [SearchWidget(), AvatarWidget(), PopupMenuWidget()]);

}


