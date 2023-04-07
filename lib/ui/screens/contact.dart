import 'package:flutter/material.dart';
import 'package:rohy/application/use_cases/add_contact.dart';
import 'package:rohy/domain/contact/contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _objetController = TextEditingController();
  final _messageController = TextEditingController();
  final _addContactUseCase = AddContactUseCase();

  void _submitForm() {
    //if (_formKey.currentState.validate()) {
      final contact = Contact(
        nom: _nomController.text,
        email: _emailController.text,
        objet: _objetController.text,
        message: _messageController.text,
        date: DateTime.now(),
      );
      _addContactUseCase.execute(contact);
      Navigator.pop(context);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactez-nous'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _objetController,
                decoration: InputDecoration(
                  labelText: 'Objet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                child: Text('Envoyer'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
