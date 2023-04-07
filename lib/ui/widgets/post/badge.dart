import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/ui/providers/notification.dart';

class BadgeNotificationWidget extends StatelessWidget {
  BadgeNotificationWidget({Key? key, required this.count}) : super(key: key);
  int count;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text('$count'),
      child: Icon(Icons.settings),
    );
  }
}
