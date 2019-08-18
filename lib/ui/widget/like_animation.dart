import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LikeAnimationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: OverflowBox(
//        maxWidth: 30.0,
//        maxHeight: 30.0,
        minWidth: 30,
        minHeight: 30,
        child: FlareActor("assets/animations/like.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "like"),
      ),
    );
  }
}
