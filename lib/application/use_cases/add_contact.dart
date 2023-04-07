import 'package:rohy/domain/contact/contact.dart';
import 'package:rohy/domain/contact/contact_repository.dart';
import 'package:rohy/infrastructure/repositories/contact.dart';

class AddContactUseCase {
  final ContactRepository _repository = ContactFirestoreRepository();
  Future<void> execute(Contact contact) async {
    await _repository.addContact(contact);
  }
}

class GetAllContactsUseCase {
  final ContactRepository _repository = ContactFirestoreRepository();
  Future<List<Contact>> execute() async {
    return await _repository.getAllContacts();
  }
}