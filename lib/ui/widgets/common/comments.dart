
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/application/use_cases/list_comments_on_object.dart';
import 'package:rohy/ui/providers/home_screen.dart';
import 'package:rohy/ui/providers/user_interaction_provider.dart';

class CommentSummary extends StatelessWidget {

  CommentSummary({Key? key, required this.count, required this.objectId}) : super(key: key);

  int? count;
  String? objectId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<UserInteractionProvider>(context, listen: false).setCurrentCommentObjectId(objectId!, ObjectType.POST);
        Provider.of<HomeScreenProvider>(context, listen: false).setIndex(4);
      },
      child: Wrap(
        spacing: 2,
        children: [
          Text("${count.toString()} commentaire(s)")
        ],
      ),
    );
  }
}

