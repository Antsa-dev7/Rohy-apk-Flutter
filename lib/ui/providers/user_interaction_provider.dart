import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:rohy/application/use_cases/react_on_post.dart';
import 'package:rohy/application/use_cases/vote_on_post.dart';
import 'package:rohy/domain/user/user.dart';

class UserInteractionProvider extends ChangeNotifier {

  // Reactions
  Map<String, String> _reactions = {};
  Map<String, Map<String?, int>> _reactionsSummaries = {};
  String _itemOnReactionChoices = "none";

  Map<String, String> get reactions {
    return _reactions;
  }

  Map<String, Map<String?, int>> get reactionsSummaries {
    return _reactionsSummaries;
  }

  String get itemOnReactionChoices {
    return _itemOnReactionChoices;
  }

  void setReactionsSummaries(Map<String, Map<dynamic, dynamic>> reactionsSummaries) {
    reactionsSummaries.forEach((key, value) {
      Map<String, int> summary = {};
      value.forEach((reaction, count) {
        summary[reaction] = count;
      });
      _reactionsSummaries[key] = summary;
    });
  }

  Future<void> updateReaction(String objectId, RohyUser? user, String reaction) async {
    if (user != null) {
      ReactOnPostUseCase useCase = ReactOnPostUseCase();
      _reactions[objectId] = reaction;
      _reactionsSummaries[objectId] = await useCase.execute(user, objectId, reaction);
      notifyListeners();
    }
  }

  void showReactionChoices(String objectId) {
    _itemOnReactionChoices = objectId;
    notifyListeners();
  }

  void setReactions(Map<String, String> reactions) {
    _reactions = reactions;
  }

  // Vote
  Map<String, double> _votes = {};
  Map<String, Map<String,double>> _votesSummaries = {};

  Map<String, double> get votes {
    return _votes;
  }

  Map<String, Map<String, double>> get votesSummaries {
    return _votesSummaries;
  }

  void setVotesSummaries(Map<String, Map<dynamic, dynamic>> votesSummaries) {
    votesSummaries.forEach((key, value) {
      Map<String, double> summary = {};
      summary["votants"] = (value["votants"] as int).toDouble();
      summary["averageVote"] = value["averageVote"];
      _votesSummaries[key] = summary;
    });
  }

  Future<void> updateVote(String objectId, RohyUser user, double vote) async {
    if (user.uid != null) {
      VoteOnPostUseCase useCase = VoteOnPostUseCase();
      // On met à jour les données dans le provider pour rafraichissement immédiat
      _votes[objectId] = vote;
      _votesSummaries[objectId] = await useCase.execute(user, objectId, vote);
      notifyListeners();
    }
  }

  void setVotes(Map<String, double> votes) {
    _votes = votes;
  }

  void reset() {
    _reactions = {};
    _reactionsSummaries = {};
    _votes = {};
    _votesSummaries = {};
  }
}