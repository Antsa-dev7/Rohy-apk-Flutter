import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rohy/infrastructure/repositories/directories.dart';
import '../../../constants.dart';
import '../../../domain/user/user.dart';
import '../../providers/user_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_form_field.dart';
import '../../widgets/loading.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  final bool isSocialLogin;
  final String socialProvider;

  const UserProfile(
      {Key? key,
        required this.uid,
        required this.isSocialLogin,
        required this.socialProvider})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserFormState();
}

class _UserFormState extends State<UserProfile> {
  // Form helpers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool isSignUpSuccess = false;
  bool isSigningSubmitted = false;

  late Future<DocumentSnapshot<Object?>> _user =
  DirectoryRepository.readUser(widget.uid);

  final Logger logger = Logger();
  String _phoneNumber = "";
  PhoneNumber _initialPhoneNumber = PhoneNumber(isoCode: "FR");

  //PhoneNumber _initialPhoneNumber = PhoneNumber(isoCode: "FR");

  @override
  void initState() {
    _firstNameController.text = "";
    _lastNameController.text = "";
    _emailController.text = "";
    _phoneNumberController.text = "";
    _addressController.text = "";
    _confirmPasswordController.text = "";
    _passwordController.text = "";
    isSignUpSuccess = false;
    isSigningSubmitted = false;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<DocumentSnapshot>(
          future: _user,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              RohyUser rohyUser = RohyUser.fromJson(data);
              _lastNameController.text = "${rohyUser.nom}";
              _firstNameController.text = "${rohyUser.prenom}";
              _emailController.text = "${rohyUser.email}";
              getPhoneNumber("${rohyUser.phone != null ? rohyUser.phone : ''}")
                  .then((val) {
                _initialPhoneNumber = val;
                print("Num $val");
                _phoneNumberController.text = _initialPhoneNumber.parseNumber().replaceAll("+", "");
              });
              _addressController.text =
              "${rohyUser.address != null ? rohyUser.address : ''}";

              return Container(
                padding: EdgeInsets.all(formPadding),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomFormField(
                            controller: _lastNameController,
                            hintText: 'Nom',
                            errorHintText: 'Entrer votre nom',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Entrer votre nom");
                              }
                              return null;
                            },
                            maxLines: 1,
                            isNumber: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomFormField(
                            controller: _firstNameController,
                            hintText: 'Prénom',
                            errorHintText: 'Entrer votre prénom',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Entrer votre prénom");
                              }
                              return null;
                            },
                            maxLines: 1,
                            isNumber: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomFormField(
                            controller: _emailController,
                            hintText: 'Adresse e-mail',
                            errorHintText: 'Entrer votre email',
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
                            maxLines: 1,
                            isNumber: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            initialValue: _initialPhoneNumber,
                            textFieldController: _phoneNumberController,
                            hintText: "Téléphone",
                            formatInput: true,
                            keyboardType:
                            TextInputType.numberWithOptions(signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomFormField(
                            controller: _addressController,
                            hintText: 'Adresse',
                            errorHintText: "Entrer l'adresse",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez votre adresse';
                              }
                              return null;
                            },
                            maxLines: 1,
                            isNumber: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomFormField(
                            controller: _passwordController,
                            hintText: 'Choisissez un mot de passe',
                            errorHintText: 'Entrer votre mot de passe',
                            validator: (value) {
                              if (value!.isEmpty && !widget.isSocialLogin) {
                                return ("Entrer votre mot de passe");
                              }
                              if (!passwordRegex.hasMatch(value) &&
                                  !widget.isSocialLogin) {
                                return ('Au moins 6 caractères, 1 majuscule, \n1 chiffre et 1 caractère spéciaux.');
                              }
                              return null;
                            },
                            maxLines: 1,
                            isNumber: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomFormField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirmer votre mot de passe',
                            errorHintText: 'Retaper votre mot de passe',
                            validator: (value) {
                              if (value!.isEmpty && !widget.isSocialLogin) {
                                return ("Retaper votre mot de passe");
                              }
                              if (_confirmPasswordController.text !=
                                  _passwordController.text &&
                                  !widget.isSocialLogin) {
                                return ("Les mots de passe ne correspondent pas");
                              }
                              return null;
                            },
                            maxLines: 1,
                            isNumber: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          (_isLoading == true)
                              ? Loading()
                              : CustomButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await _updateUser(_phoneNumber,
                                    widget.isSocialLogin);
                              }
                            },
                            buttonText: "Modifier",
                            buttonColor: Colors.blue.shade900,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<PhoneNumber> getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
    return number;
  }

  Future<void> _updateUser(String phoneNumber, bool isSocialLogin) async {
    RohyUser? rohyUser = Provider.of<UserProvider>(context, listen: false).user;
    rohyUser!.email = _emailController.text;
    rohyUser!.prenom = _firstNameController.text;
    rohyUser!.nom = _lastNameController.text;
    rohyUser!.phone = _phoneNumberController.text;
    rohyUser!.address = _addressController.text;

    DirectoryRepository.updateUser(
        rohyUser, _passwordController.text, isSocialLogin);
    Provider.of<UserProvider>(context, listen: false).setUser(rohyUser, "UpdateUser");
  }
}