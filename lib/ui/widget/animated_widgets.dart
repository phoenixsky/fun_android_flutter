
import 'package:flutter/widgets.dart';

class AnimatedScaleSwitcher extends StatelessWidget {
  const AnimatedScaleSwitcher({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class FadeOutSwitcher extends StatelessWidget {
  final bool isVisible;
  final Widget child;

  const FadeOutSwitcher(
      {super.key, this.isVisible = true, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleSwitcher(
      child: isVisible ? child : const SizedBox.shrink(),
    );
  }
}
