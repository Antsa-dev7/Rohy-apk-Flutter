import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: IconButton(
              onPressed: () =>  print("Search bar pressed"),
              icon: const Icon(Icons.search)
          ),
        ),
      );
  }
}
