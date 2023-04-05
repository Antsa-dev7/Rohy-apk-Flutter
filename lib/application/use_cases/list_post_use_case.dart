import 'package:rohy/domain/post/post.dart';
import 'package:rohy/infrastructure/repositories/posts.dart';

class ListPostUseCase {

  final PostRepository _repository = PostRepository();
  Future<List<Post>> execute() async {
    return await _repository.loadAllPosts();
  }

}