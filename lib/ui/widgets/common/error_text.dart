// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final double imageSize;
  final String iconImage;
  final String errorMessage;
  const ErrorText(
      {super.key,
      required this.imageSize,
      required this.iconImage,
      required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconImage, width: imageSize),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 255,
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
