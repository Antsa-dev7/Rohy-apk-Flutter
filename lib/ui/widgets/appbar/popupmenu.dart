import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) {
      return [
        const PopupMenuItem<int>(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('CGU'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child:  ListTile(
            leading: Icon(Icons.delete_rounded),
            title: Text('Effacer mes données'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child:  ListTile(
            leading: Icon(Icons.phone),
            title: Text('Contacter Rohy'),
          ),
        ),
      ];
    }, onSelected: (value) {
      if (value == 0) {
        print("Menu 1");
      } else if (value == 1) {
        print("Menu 2");
      } else if (value == 2) {
        print("Menu 3");
      }
    });
  }
}
