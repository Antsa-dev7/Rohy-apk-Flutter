import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rohy/application/use_cases/list_post.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/ui/providers/home_screen.dart';
import 'package:rohy/ui/providers/user_interaction_provider.dart';
import 'package:rohy/ui/providers/user_provider.dart';
import 'package:rohy/ui/widgets/common/comments.dart';
import 'package:rohy/ui/widgets/post/post_item.dart';
import 'package:rohy/ui/widgets/common/reaction.dart';
import 'package:rohy/ui/widgets/common/vote.dart';

import '../../../application/use_cases/list_comments_on_object.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ScrollController _controller = ScrollController();

  void _onScrollEvent() {
    if (_controller.hasClients) {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        debugPrint("Reach the bottom: load next n offers");
      }
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      debugPrint("Reach the top: load next n offers");
    }
  }

  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ListPostUseCase listPostUseCase = ListPostUseCase();
    return Container(
      padding: EdgeInsets.all(2),
      child: FutureBuilder<List<Post>>(
        future: listPostUseCase.execute(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [CircularProgressIndicator()]);
          }
          if (snapshot.hasData) {

            // Init data from user info
            Map<String, Map<dynamic, dynamic>> reactionsSummaries = {};
            Map<String, String> reactions = {};
            Map<String, Map<dynamic, dynamic>> votesSummaries = {};
            Map<String, double> votes = {};

            RohyUser? rohyUser = Provider.of<UserProvider>(context, listen: false).user;

            snapshot.data?.forEach((element) {
              if (element.reactionDetails != null) {
                reactionsSummaries[element.id] = element.reactionDetails!;
              }
              votesSummaries[element.id] = { "votants": element.votants, "averageVote": element.averageVotes };

              if (rohyUser != null) {
                if (rohyUser.postReactions != null)
                  if (rohyUser.postReactions!.containsKey(element.id)) {
                    reactions[element.id] = rohyUser.postReactions![element.id]!;
                  }
                if (rohyUser.postVotes != null)
                  if (rohyUser.postVotes!.containsKey(element.id)) {
                    votes[element.id] = rohyUser.postVotes![element.id];
                  }
              }
            });

            Provider.of<UserInteractionProvider>(context, listen: false ).setReactionsSummaries(reactionsSummaries);
            Provider.of<UserInteractionProvider>(context, listen: false ).setVotesSummaries(votesSummaries);
            Provider.of<UserInteractionProvider>(context, listen: false ).setReactions(reactions);
            Provider.of<UserInteractionProvider>(context, listen: false ).setVotes(votes);

            return ListView.separated(
              controller: _controller,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 3);
              },
              itemBuilder: (context, index) {
                return Column(
                    children: [PostItemDetailsWidget(
                      author: snapshot.data![index].getName(),
                      title: snapshot.data![index].title,
                      avatar: snapshot.data![index].getPhotoUrl(),
                      description: snapshot.data![index].description,
                      date: DateTime.now(),
                      photo: snapshot.data![index].image,
                    ),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReactionSummary(objectId: snapshot.data![index].id),
                                    CommentSummary(count: snapshot.data![index].countComments ?? 0, objectId: snapshot.data![index].id),
                                    VoteSummary(objectId: snapshot.data![index].id)
                                  ]
                              ),
                              Divider(),
                              if (FirebaseAuth.instance.currentUser != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReactionWidget(objectId: snapshot.data![index].id),
                                    Expanded(
                                        child: InkWell(
                                          onTap: (){
                                              Provider.of<UserInteractionProvider>(context, listen: false).setCurrentCommentObjectId(snapshot.data![index].id, ObjectType.POST);
                                              Provider.of<HomeScreenProvider>(context, listen: false).setIndex(4);
                                          },
                                            child: Text("Commenter")
                                        )
                                    ),
                                    VoteWidget(objectId: snapshot.data![index].id)
                                  ],
                                ),
                            ]
                        ),
                      ),
                  ]);
              },
            );
          } else {
            return Text("Aucune annonce trouvée!");
          }
        },
      ),
    );
  }
}
