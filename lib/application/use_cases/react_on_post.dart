import 'package:logger/logger.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';
import 'package:rohy/infrastructure/repositories/posts.dart';

class ReactOnPostUseCase {

  final PostRepository _repository = PostRepository();
  final DirectoryRepository _directoryRepository = DirectoryRepository();

  Future<Map<String?, int>> execute(RohyUser user, String postId, String reaction) async {
    await _repository.addOrUpdateReaction(user, postId, reaction);
    List<ReactionOnObject> reactions = await _repository.loadReactions(postId);
    await _directoryRepository.addOrUpdateUserPostReaction(user, postId, reaction);
    Map<String?, int> reactionDetails = {};
    reactions.forEach((element) {
      if (!reactionDetails.containsKey(element.type))
        reactionDetails[element.type] = 0;
      reactionDetails[element.type] = (reactionDetails[element.type])! + 1;
    });
    // Update post vote average and count
    await _repository.updatePostReaction(postId, reactions.length, reactionDetails);
    return reactionDetails;
  }
}