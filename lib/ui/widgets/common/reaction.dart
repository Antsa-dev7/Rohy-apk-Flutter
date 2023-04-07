
import 'package:flutter/material.dart';

class ReactionWidget extends StatefulWidget {

  ReactionWidget({Key? key, required this.reaction } ) : super(key: key);

  String reaction = "none";

  @override
  State<ReactionWidget> createState() => _ReactionWidgetState();
}

class _ReactionWidgetState extends State<ReactionWidget> {

  @override
  Widget build(BuildContext context) {
    return Reaction.getReactionIcon(widget.reaction);
  }

}

class ReactionSummary extends StatelessWidget {

  Map<String, int>? summary;

  ReactionSummary({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children =  [];
    int total = 0;
    if (summary != null) {
      summary?.forEach((key, value) {
        total += value;
        children.add(Reaction.getReactionIcon(key));
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
      case "like" :
        return const Icon(
          Icons.thumb_up,
          color: Colors.blueAccent, size: 22,
        );
      case "love":
        return const Icon(
          Icons.favorite,
          color: Colors.redAccent, size: 22,
        );
      case "unlike":
        return const Icon(
          Icons.thumb_down_alt,
          color: Colors.purpleAccent, size: 22,
        );
      default :
        return const Icon(
          Icons.thumb_up_alt_outlined, size: 22,
        );
    }
  }
}


