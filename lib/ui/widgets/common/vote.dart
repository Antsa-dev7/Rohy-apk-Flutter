
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VoteWidget extends StatefulWidget {
  const VoteWidget({Key? key}) : super(key: key);

  @override
  State<VoteWidget> createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: 0,
        minRating: 0,
        // Can't vote if not connected
        ignoreGestures: true,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 20,
        itemBuilder: (context, _) =>
            Icon(Icons.star, color: Colors.amber,),
        onRatingUpdate: (rating) {

        }
    );
  }
}

class VoteSummary extends StatelessWidget {

  VoteSummary({Key? key, required this.votants, required this.averageVotes}) : super(key: key);
  int? votants = 0;
  double? averageVotes = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            child: Text("(${votants})")
          ),
          const SizedBox(width: 5),
          RatingBar.builder(
              initialRating: averageVotes ?? 0,
              minRating: 0,
              // Can't vote if not connected
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber,),
              onRatingUpdate: (rating) {

              }
              ),
        ]
    );
  }
}
