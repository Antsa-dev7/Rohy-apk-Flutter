import 'package:flutter/material.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/screens/post/list.dart';

class PostAndEnterpriseTab extends StatelessWidget {
  const PostAndEnterpriseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Column(
              children: const [
                TabBar(
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                        child: Text(
                          "Annonces",
                          style: tabTitleStyle,
                        )
                    ),
                    Tab(
                        child: Text(
                          "Nos entreprises",
                          style: tabTitleStyle,
                        )
                    ),
                  ],
                ),
              ],
            )),
        body: TabBarView(
          children: [
            PostsScreen(),
            Text("Enteprises"),
          ],
        ),
      ),
    );
  }
}
