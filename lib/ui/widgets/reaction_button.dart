import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/ui/providers/user_interaction_provider.dart';
import 'package:rohy/ui/providers/user_provider.dart';

enum ReactionType {
  like,
  love,
  unlike,
  none
}

class ReactionButton extends StatelessWidget {
  String objectId;
  IconData icon;
  ReactionType type;
  final Color? color;

  ReactionButton({
    Key? key,
    required this.objectId,
    required this.icon,
    required this.type,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        RohyUser? rohyUser = Provider.of<UserProvider>(context, listen: false).user;
        Provider.of<UserInteractionProvider>(context, listen: false).updateReaction(objectId, rohyUser, this.type.name );
        rohyUser!.setReaction(objectId, this.type.name);
        Provider.of<UserProvider>(context, listen: false).setUser(rohyUser, "updateReaction");
        Provider.of<UserInteractionProvider>(context, listen: false).showReactionChoices("none");
        },
      child:
        Icon(icon, color: color,)
    );
  }
}

