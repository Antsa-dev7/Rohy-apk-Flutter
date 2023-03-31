import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rohy/constants.dart';
import 'package:rohy/infrastructure/iam/sign_mail.dart';
import 'package:rohy/ui/screens/home.dart';
import 'package:rohy/ui/widgets/custom_button.dart';
import 'package:rohy/ui/widgets/custom_form_field.dart';
import 'package:rohy/ui/widgets/error_text.dart';

class EmailAuthWidget extends StatefulWidget {
  const EmailAuthWidget({Key? key}) : super(key: key);

  @override
  State<EmailAuthWidget> createState() => _EmailAuthWidgetState();
}

class _EmailAuthWidgetState extends State<EmailAuthWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isAuthSuccess = false;
  bool isSigningSubmitted = false;

  @override
  void initState() {
    _emailController.text = "";
    _passwordController.text = "";
    isAuthSuccess = false;
    isSigningSubmitted = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(formPadding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Form
              (isAuthSuccess == true || isSigningSubmitted == false)
                  ? SizedBox()
                  : const ErrorText(
                errorMessage:
                "L'email ou le mot de passe que vous avez saisi est incorrect ou invalide",
                iconImage: 'assets/icons/warning_icon.png',
                imageSize: 50,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _emailController,
                      hintText: "Adresse e-mail",
                      type: TextInputType.emailAddress,
                      errorHintText: 'Entrer votre e-mail',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Entrer votre addresse e-mail");
                        }
                        return null;
                      },
                      isNumber: false,
                    ),
                    const SizedBox(
                      height: formPadding,
                    ),
                    CustomFormField(
                      controller: _passwordController,
                      hintText: "Mot de passe",
                      type: TextInputType.visiblePassword,
                      maxLines: 1,
                      errorHintText: 'Entrer votre mot de passe',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Entrer votre addresse passe");
                        }
                        return null;
                      },
                      isNumber: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onTap: () {
                        connect(context);
                      },
                      buttonText: "Se connecter",
                      buttonColor: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              )
            ]));
  }

  Future<void> connect(BuildContext context) async {
    bool? authResult;
    if (_formKey.currentState!.validate()) {
      authResult = await FirebaseSignInByMail(FirebaseAuth.instance)
          .signIn(
          email: _emailController.text,
          password: _passwordController.text);
      isSigningSubmitted = true;
      if (authResult == false) {
        setState(() {
          isAuthSuccess = false;
          print("Failed login");
        });
      } else {
        setState(() {
          isAuthSuccess = true;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
                (route) => false,
          );
        });
      }
    }
  }
}
