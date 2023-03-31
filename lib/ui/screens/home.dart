import 'package:flutter/material.dart';
import 'package:rohy/ui/widgets/appbar/appbar.dart';

import '../widgets/bottombar/bottombar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print('i was tapped!'),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white.withOpacity(0.90), Colors.white]),
            ),
            child: Scaffold(
                // drawer: const MenuWidget(),
                backgroundColor: Colors.transparent,
                appBar: AppBarWidget(),
                body: Text("PlaceHolder"),
                bottomNavigationBar: BottomBarWidget())));
  }
}
