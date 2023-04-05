import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  TextEditingController textController;
  String label;
  InputText({Key? key,required this.textController,required this.label}) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              labelText: widget.label,
              //icon: Icon(Icons.supervised_user_circle_outlined,size: 40,),
              //border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              // do something with the text entered in the field
              print(text);
              widget.textController = _textEditingController;
            },
          ),
          SizedBox(height: 16.0),
        ],
    );
  }
}
