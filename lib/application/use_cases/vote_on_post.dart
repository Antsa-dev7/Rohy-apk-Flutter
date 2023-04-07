import 'package:logger/logger.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';
import 'package:rohy/infrastructure/repositories/posts.dart';

class VoteOnPostUseCase {

  final PostRepository _repository = PostRepository();
  final DirectoryRepository _directoryRepository = DirectoryRepository();

  Future<Map<String, double>> execute(RohyUser user, String postId, double vote) async {
    await _repository.addOrUpdateVote(user, postId, vote);
    List<PostVote> votes = await _repository.loadVotes(postId);
    await _directoryRepository.addOrUpdateUserPostVote(user, postId, vote);
    // Update post vote average and count
    var sum = 0.0;
    votes.forEach((element) => sum += element.vote as double);
    var averageVote = votes.length > 0 ? sum/votes.length: vote;
    await _repository.updatePostVotant(postId, votes.length, averageVote);
    Map<String, double> voteSummary = {};
    voteSummary["votants"] = votes.length.toDouble();
    voteSummary["averageVote"] = averageVote;
    Logger().d(voteSummary);
    return voteSummary;
  }
}