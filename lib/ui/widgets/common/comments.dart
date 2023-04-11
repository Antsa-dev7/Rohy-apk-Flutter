
import 'package:flutter/material.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({Key? key}) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 2,
        children: [
          Icon(Icons.add_comment, size: 22,),
        ]
    );
  }
}

class CommentSummary extends StatelessWidget {

  CommentSummary({Key? key, required this.count}) : super(key: key);

  int? count;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      children: [
        Icon(Icons.insert_comment_outlined, size: 22,),
        Text(count.toString())
      ],
    );
  }
}
