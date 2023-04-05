import 'package:firebase_auth/firebase_auth.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';

class SaveSocialUserUseCase {

  final DirectoryRepository _repository = DirectoryRepository();

  Future<RohyUser> execute(User googleUser) async {
    RohyUser user = await _repository.saveSocialUser(googleUser: googleUser, type: "Fournisseur", status: "Valid");
    return user;
  }
}