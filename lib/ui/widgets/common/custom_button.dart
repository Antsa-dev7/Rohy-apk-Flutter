// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String? imagePath;
  final VoidCallback onTap;
  final double? imageWidth;
  final Color buttonColor;
  final Color textColor;
  const CustomButton(
      {Key? key,
      required this.onTap,
      this.imagePath,
      required this.buttonText,
      this.imageWidth,
      required this.buttonColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // general helpers
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: MaterialButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 45,
        minWidth: deviceWidth,
        onPressed: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (imagePath != null)
                  ? Image.asset(
                      imagePath!,
                      width: imageWidth,
                    )
                  : Container(),
              Expanded(
                flex: 4,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
