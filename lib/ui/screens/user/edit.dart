import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/domain/user/user.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/input_text.dart';

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
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _firstName;
  String? _lastName;
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = RohyUser(
        nom: _firstName,
        prenom: _lastName,
        email: _emailController.text,
        //phone: _phoneNumberController,
        //address: _addressController,
        //photoURL: _photoController,
      );
      //_addContactUseCase.execute(contact);
    }
  }
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
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        width: 120,
                        height: 120,
                        child: Stack(
                          children: <Widget>[
                             Align(
                                alignment: Alignment.bottomCenter,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                "${FirebaseAuth.instance.currentUser?.photoURL}"),
                                  radius: 60,
                                ),
                              ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(left: 60, top: 30),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: quaternaryColor,
                                  child:  Icon(Icons.edit,size: 30,color: Colors.white,),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: (){},
                  ),
                  InputText(
                    textEditingController: _firstNameController,
                    hintText: 'Nom',
                    errorText : 'Entrer votre nom',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrer votre nom';
                      }
                      return null;
                    },
                  ),
                  InputText(
                    textEditingController: _lastNameController,
                    hintText: 'Prénom',
                    errorText : '',
                    validator: (value) {
                      return null;
                    },
                  ),
                  InputText(
                    textEditingController: _lastNameController,
                    hintText: 'Email',
                    errorText : 'Entrer votre email',
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Entrer votre email");
                      }
                      if (!EmailValidator.validate(value)) {
                        return ('Entrer un addresse email valide');
                      }
                      return null;
                    },
                  ),
                  IntlPhoneField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Téléphone',
                      border: OutlineInputBorder(),
                    ),
                    disableLengthCheck : true,
                    initialCountryCode: 'FR',
                    searchText: 'Rechercher pays',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    invalidNumberMessage : 'Numéro téléplone invalide',
                    validator: (value) {
                      if (value == null ) {
                        return ("Entrer votre numéro télephone");
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  InputText(
                    textEditingController: _lastNameController,
                    hintText: 'Adresse',
                    errorText : 'Entrer votre adresse',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Entrer votre adresse");
                      }
                      return null;
                    },
                  ),
                  InputText(
                    textEditingController: _lastNameController,
                    hintText: 'Mot de passe',
                    errorText : '',
                    validator: (value) {
                      return null;
                    },
                  ),
                  InputText(
                    textEditingController: _lastNameController,
                    hintText: 'Confirmer votre mot de passe',
                    errorText : '',
                    validator: (value) {
                      return null;
                    },
                  ),
                  CustomButton(
                    onTap: (){},
                    buttonColor: quaternaryColor,
                    buttonText: 'Modifier',
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
