import 'package:logger/logger.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';

class LoadUserUseCase {

  final DirectoryRepository _repository = DirectoryRepository();

  Future<RohyUser> execute(String? uid) async {
    Logger().e(uid);
    final user = await _repository.readRohyUser(uid);
    // Load Enterprise Votes
    List<EntepriseVote> votes = await _repository.readRohyUserEnterpriseVotes(uid);
    user.enterpriseVotes = votes;
    return user;
  }
}