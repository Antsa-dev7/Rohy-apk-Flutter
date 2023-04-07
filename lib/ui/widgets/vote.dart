
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/ui/providers/user_provider.dart';

import '../providers/user_interaction_provider.dart';

class VoteWidget extends StatelessWidget {

  VoteWidget({Key? key, required this.objectId}) : super(key: key);

  String objectId;

  @override
  Widget build(BuildContext context) {
    var vote = context.select<UserInteractionProvider, double?>(
            (postProvider) => postProvider.votes[objectId]
    );
    // Si on n'est pas connecté, on affiche grisé
    if (FirebaseAuth.instance.currentUser == null)
      vote = 0;

    return RatingBar.builder(
        initialRating: vote ?? 0,
        minRating: 0,
        // Can't vote if not connected
        ignoreGestures: FirebaseAuth.instance.currentUser == null,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 20,
        itemBuilder: (context, _) =>
            Icon(Icons.star, color: Colors.amber,),
        onRatingUpdate: (rating) {
          RohyUser? rohyUser = Provider.of<UserProvider>(context, listen: false).user;
          Provider.of<UserInteractionProvider>(context, listen: false).updateVote(objectId, rohyUser!, rating );
          rohyUser.setVote(objectId, rating);
          Provider.of<UserProvider>(context, listen: false).setUser(rohyUser, "updateVote");
        }
    );
  }
}

class VoteSummary extends StatelessWidget {

  VoteSummary({Key? key, required this.objectId}) : super(key: key);
  String objectId;

  @override
  Widget build(BuildContext context) {
    // S'abonner sur la modification de l'élement côté provider
    var summary =
    context.select<UserInteractionProvider, Map<String?, double>?>(
            (postProvider) => postProvider.votesSummaries[objectId]);
    return Row(
        children: [
          Container(
            child: Text("(${summary!['votants']})")
          ),
          const SizedBox(width: 5),
          RatingBar.builder(
              initialRating: summary['averageVote'] ?? 0,
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
