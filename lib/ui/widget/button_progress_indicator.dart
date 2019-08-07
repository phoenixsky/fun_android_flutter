import 'package:flutter/material.dart';

class ButtonProgressIndicator extends StatelessWidget {

  final double size;
  final Color color;

  ButtonProgressIndicator(
      { this.size: 24, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}
