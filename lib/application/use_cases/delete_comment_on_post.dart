import 'package:logger/logger.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';
import 'package:rohy/infrastructure/repositories/posts.dart';

class DeleteCommentOnPostUseCase {

  final PostRepository _repository = PostRepository();

  Future<List<CommentOnObject>> execute(String postId, String commentId) async {
    await _repository.removeComment(postId, commentId);
    List<CommentOnObject> comments = await _repository.loadComments(postId);
    // Update post vote average and count
    await _repository.updatePostCommentsCount(postId, comments.length);
    return comments;
  }
}