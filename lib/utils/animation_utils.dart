import 'package:flutter/widgets.dart';

class AnimationUtils{

  static Widget scaleTransitionBuilder(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}