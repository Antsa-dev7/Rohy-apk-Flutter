import 'package:flutter/material.dart';

import 'custom_form_field.dart';
class InputText extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  String errorText;
  TextInputType? type;
  String? Function(String?)? onChanged;
  String? Function(String?)? validator;
  String? Function(String?)? onSaved;
  InputText({Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.errorText,
    this.type,
    this.validator,
  }) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          controller: textEditingController,
          hintText: hintText,
          errorHintText: errorText,
          validator: validator,
          maxLines: 1,
          type: TextInputType.text,
          isNumber: false,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}




