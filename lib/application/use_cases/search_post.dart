import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';

class SearchPostUseCase {

  final DirectoryRepository _repository = DirectoryRepository();

  Future<RohyUser> execute(String? uid) async {
    return RohyUser();
  }
}