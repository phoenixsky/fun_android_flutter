import 'package:flutter/material.dart';

class ScaleAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  ScaleAnimatedSwitcher({this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class EmptyAnimatedSwitcher extends StatelessWidget {
  final bool display;
  final Widget child;

  EmptyAnimatedSwitcher({this.display: true, this.child});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitcher(child: display ? child : SizedBox.shrink());
  }
}
