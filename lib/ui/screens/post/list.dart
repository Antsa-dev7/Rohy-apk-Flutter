import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rohy/application/use_cases/list_post_use_case.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/ui/providers/user_provider.dart';
import 'package:rohy/ui/widgets/common/comments.dart';
import 'package:rohy/ui/widgets/post/post_item.dart';
import 'package:rohy/ui/widgets/common/reaction.dart';
import 'package:rohy/ui/widgets/common/vote.dart';

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
    return FutureBuilder<List<Post>>(
      future: listPostUseCase.execute(),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        RohyUser user = Provider.of<UserProvider>(context, listen: false).user;
        Logger().i(user.postVotes);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [CircularProgressIndicator()]);
        }
        if (snapshot.hasData) {
          return ListView.separated(
            controller: _controller,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 3);
            },
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                color: Colors.white,
                margin: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
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
                                children: [
                                  // ReactionSummary(summary: snapshot.data![index].reaction),
                                  ReactionSummary(summary: { "love": 1, "like": 300}),
                                  Spacer(),
                                  CommentSummary(count: 10),
                                  Spacer(),
                                  VoteSummary(votants: snapshot.data![index].votants, averageVotes: snapshot.data![index].averageVotes)
                                ]
                            ),
                            Divider(),
                            Row(
                              children: [
                                ReactionWidget(reaction: 'love',),
                                Spacer(),
                                CommentsWidget(),
                                Spacer(),
                                VoteWidget()
                              ],
                            ),
                          ]
                      ),
                    ),
                ]),
              );
            },
          );
        } else {
          return Text("Aucune annonce trouvée!");
        }
      },
    );
  }
}
