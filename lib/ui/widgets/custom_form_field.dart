// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_if_null_operators
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? type;
  final String errorHintText;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  final bool isNumber;
  final Image? icon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.type,
    required this.errorHintText,
    this.validator,
    this.minLines,
    this.maxLines,
    required this.isNumber,
    this.icon,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isObscureText = true;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(

          suffixIcon: suffixIcon == null ? null : suffixIcon,
          prefixIcon: icon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: icon,
                ),
          prefixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFC1CFDA))),
      keyboardType: (type) != null ? type : null,
      inputFormatters: (isNumber)
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[0-9.,+]')),
            ]
          : null,
      obscureText: (hintText.contains('mot de passe') ||
              hintText.contains('Mot de passe'))
          ? _isObscureText
          : !_isObscureText,
      validator: validator,
      onSaved: (val) {
        controller.text = val!;
      },
      minLines: (minLines) != null ? minLines : null,
      maxLines: (maxLines) != null ? maxLines : null,
    );
  }
}
