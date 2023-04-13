import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/ui/providers/user_interaction_provider.dart';
import 'package:rohy/ui/providers/user_provider.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({Key? key}) : super(key: key);
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _commentController.text = "";
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Consumer<UserInteractionProvider>(builder: (context, model, child) {
            List<CommentOnObject> comments = model.currentComments;
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: quinaryColor,
                ),
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              comments[index].rohyUser!["photoURL"]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ReadMoreText(
                          comments[index].comment,
                          trimLines: 1,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' Voir plus',
                          trimExpandedText: ' Voir moins',
                          style: postContentStyle,
                          moreStyle: moreTextStyle,
                          lessStyle: moreTextStyle,
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        (FirebaseAuth.instance.currentUser != null &&
                                FirebaseAuth.instance.currentUser!.uid ==
                                    comments[index].rohyUser!["uid"])
                            ? TextButton.icon(
                                onPressed: () {
                                  Provider.of<UserInteractionProvider>(context,
                                          listen: false)
                                      .deleteComment(
                                          comments[index].objectId ?? "",
                                          comments[index].id ?? "");
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: quinaryColor,
                                ),
                                label: Text(""))
                            : Text(""),
                      ]);
                },
              ),
            );
          }),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration:
                        InputDecoration(hintText: "Ajouter un commentaire"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_rounded, color: quinaryColor),
                  onPressed: () {
                    RohyUser? user =
                        Provider.of<UserProvider>(context, listen: false).user;
                    String postId = Provider.of<UserInteractionProvider>(
                            context,
                            listen: false)
                        .currentCommentObjectId;
                    Provider.of<UserInteractionProvider>(context, listen: false)
                        .addComment(user!, postId, _commentController.text);
                    // Provider.of<HomeScreenProvider>(context, listen: false).setIndex(4);
                    _commentController.text = "";
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
