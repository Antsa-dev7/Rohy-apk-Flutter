
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.redAccent,
          size: 40,
        ),
      ),
    );
  }
}
