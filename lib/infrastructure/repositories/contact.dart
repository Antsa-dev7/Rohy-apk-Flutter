import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rohy/domain/contact/contact.dart';
import 'package:rohy/domain/contact/contact_repository.dart';

class ContactFirestoreRepository implements ContactRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = "contacts";

  Future<void> addContact(Contact contact) async {
    await _firestore.collection(_collectionName).add({
      "nom": contact.nom,
      "email": contact.email,
      "objet": contact.objet,
      "message": contact.message,
      "date": FieldValue.serverTimestamp(),
    });
  }

  Future<List<Contact>> getAllContacts() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection(_collectionName).get();

    List<Contact> contacts = [];
    for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
      //Contact contact = Contact.fromMap(snapshot.data());
      //contacts.add(contact);
    }

    return contacts;
  }
}