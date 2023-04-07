import 'package:flutter/material.dart';

import 'custom_form_field.dart';

class InputText extends StatefulWidget {
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

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          CustomFormField(
            controller: widget.textEditingController,
            hintText: widget.hintText,
            errorHintText: widget.errorText,
            validator: widget.validator,
            maxLines: 1,
            type: TextInputType.text,
            isNumber: false,
          ),
          SizedBox(height: 16.0),
        ],
    );
  }
}
