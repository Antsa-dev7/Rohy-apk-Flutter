import 'package:logger/logger.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';
import 'package:rohy/infrastructure/repositories/posts.dart';

enum ObjectType {
  POST(0),
  ENTERPRISE(1);

  const ObjectType(this.value);
  final int value;
}
class ListCommentsOnObjectUseCase {

  final PostRepository _repository = PostRepository();

  Future<List<CommentOnObject>> execute(String objectId, ObjectType objectType) async {
    await _repository.loadComments(objectId);
    List<CommentOnObject> comments = await _repository.loadComments(objectId);
    return comments;
  }
}