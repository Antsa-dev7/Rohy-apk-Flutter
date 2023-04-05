import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../widgets/input_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  // Définition des TextEditingController pour les champs de saisie
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputText(textController: _firstNameController, label: 'Nom',),
                  InputText(textController: _lastNameController, label: 'Prénom',),
                  InputText(textController: _birthdayController, label: 'Date de naissance',),
                  InputText(textController: _emailController, label: 'Email',),
                  /*IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    initialCountryCode: 'US',
                    onChanged: (phone) {
                      //print(phone.completeNumber);
                    },
                    onSaved: (phone) {
                     // print(phone.completeNumber);
                      // save to backend
                    },
                  ),*/
                  InputText(textController: _birthdayController, label: 'Téléphone',),
                  InputText(textController: _birthdayController, label: 'Adresse',),
                  InputText(textController: _birthdayController, label: 'Mot de passe',),

                  ElevatedButton(
                    child: const Text('Envoyer'),
                    onPressed: (){},
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
