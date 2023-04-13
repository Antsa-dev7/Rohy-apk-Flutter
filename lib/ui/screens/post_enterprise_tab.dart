import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/ui/providers/notification.dart';
import 'package:rohy/ui/screens/post/list.dart';
import 'package:rohy/ui/widgets/post/badge.dart';

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
              children: [
                TabBar(
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                        child: Row(
                          children:[
                            Text(
                              "Annonces",
                              style: tabTitleStyle,
                            ),
                            Consumer<NotificationProvider>(builder: (context, notification, child){
                              return BadgeNotificationWidget(count: notification.count,);
                              })]
                              )
                              ),
                              Tab(
                              child
                              : Text(
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
