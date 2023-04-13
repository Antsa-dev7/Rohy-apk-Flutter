import 'package:logger/logger.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';
import 'package:rohy/infrastructure/repositories/posts.dart';

class CommentOnPostUseCase {

  final PostRepository _repository = PostRepository();

  Future<List<CommentOnObject>> execute(RohyUser user, String postId, String comment) async {
    await _repository.addOrUpdateComment(user, postId, comment);
    List<CommentOnObject> comments = await _repository.loadComments(postId);
    // Update post vote average and count
    await _repository.updatePostCommentsCount(postId, comments.length);
    return comments;
  }
}