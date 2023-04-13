import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/ui/providers/notification.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: IconButton(
              onPressed: () {
                Provider.of<NotificationProvider>(context, listen: false).search();
              },
              icon: const Icon(Icons.search)
          ),
        ),
      );
  }
}
