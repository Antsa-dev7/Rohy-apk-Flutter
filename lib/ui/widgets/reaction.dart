import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rohy/ui/providers/user_interaction_provider.dart';
import 'package:rohy/ui/widgets/reaction_button.dart';

class ReactionWidget extends StatelessWidget {
  ReactionWidget({Key? key, required this.objectId})
      : super(key: key);

  String reaction = "none";
  String objectId;

  @override
  Widget build(BuildContext context) {
    var showChoices = context.select<UserInteractionProvider, bool>(
        (postProvider) => postProvider.itemOnReactionChoices == objectId);

    reaction = context.select<UserInteractionProvider, String>(
            (postProvider) => postProvider.reactions[objectId] ?? "none"
    );
    if (FirebaseAuth.instance.currentUser == null)
      reaction = "none";
    return IndexedStack(
        clipBehavior: Clip.none,
        index: showChoices ? 0 : 1,
        children: [
          ReactionChoiceWidget(objectId: objectId),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: () {
                if (FirebaseAuth.instance.currentUser != null)
                  Provider.of<UserInteractionProvider>(context,
                          listen: false)
                      .showReactionChoices(objectId);
              },
              child: IconButton(
                  onPressed: () {
                    Provider.of<UserInteractionProvider>(context,
                            listen: false)
                        .showReactionChoices("none");
                  },
                  icon: Reaction.getReactionIcon(reaction)),
            ),
          ),
        ]);
  }
}

class ReactionSummary extends StatelessWidget {
  String objectId;

  ReactionSummary({Key? key, required this.objectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var summary =
        context.select<UserInteractionProvider, Map<String?, int>?>(
            (postProvider) => postProvider.reactionsSummaries[objectId]);
    List<Widget> children = [];
    int total = 0;
    if (summary != null) {
      summary?.forEach((key, value) {
        total += value;
        children.add(Reaction.getReactionIcon(key!));
      });
      children.add(Text(total.toString()));
    }
    return Wrap(
      spacing: 3,
      children: children,
    );
  }
}

class Reaction {
  static Icon getReactionIcon(String r) {
    switch (r) {
      case "like":
        return const Icon(
          Icons.thumb_up,
          color: Colors.blueAccent,
          size: 22,
        );
      case "love":
        return const Icon(
          Icons.favorite,
          color: Colors.redAccent,
          size: 22,
        );
      case "unlike":
        return const Icon(
          Icons.thumb_down_alt,
          color: Colors.purpleAccent,
          size: 22,
        );
      default:
        return const Icon(
          Icons.thumb_up_alt_outlined,
          size: 22,
        );
    }
  }
}

class ReactionChoiceWidget extends StatelessWidget {
  ReactionChoiceWidget({Key? key, required this.objectId}) : super(key: key);
  String objectId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 140,
      margin: EdgeInsets.only(left: 0, bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(189, 189, 189, 0.7),
            //color of shadow
            blurRadius: 7,
            // blur radius
            offset: Offset(0, 6), // changes position of shadow
          ),
          //you can set more BoxShadow() here
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ReactionButton(
            objectId: objectId,
            icon: Icons.thumb_up,
            color: Colors.blueAccent,
            type: ReactionType.like,
          ),
          ReactionButton(
            objectId: objectId,
            icon: Icons.favorite,
            color: Colors.redAccent,
            type: ReactionType.love,
          ),
          ReactionButton(
            objectId: objectId,
            icon: Icons.thumb_down,
            color: Colors.purple,
            type: ReactionType.unlike,
          ),
        ],
      ),
    );
  }
}
