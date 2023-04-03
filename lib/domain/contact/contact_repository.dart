import 'package:rohy/domain/contact/contact.dart';

abstract class ContactRepository {
  Future<void> addContact(Contact contact);
  Future<List<Contact>> getAllContacts();
}