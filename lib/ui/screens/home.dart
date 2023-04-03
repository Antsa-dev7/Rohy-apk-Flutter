import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/ui/providers/home_screen.dart';
import 'package:rohy/ui/screens/post/add_edit_post.dart';
import 'package:rohy/ui/screens/post/list.dart';
import 'package:rohy/ui/screens/user/edit.dart';
import 'package:rohy/ui/widgets/appbar/appbar.dart';

import '../widgets/bottombar/bottombar.dart';


class HomeScreen extends StatelessWidget {

  static final List<Widget>  _widgets = <Widget>[
    PostsScreen(),
    AddEditPostScreen(),
    EditProfileScreen()
  ];


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
                body: _widgets[Provider.of<HomeScreenProvider>(context, listen: true).index],
                bottomNavigationBar: BottomBarWidget())));
  }
}
