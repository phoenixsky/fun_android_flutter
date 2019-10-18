import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 由于app不管明暗模式,都是有底色
/// 所以将indicator颜色为亮色
class ActivityIndicator extends StatelessWidget {
  final double radius;
  final Brightness brightness;

  ActivityIndicator({this.radius, this.brightness});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          cupertinoOverrideTheme: CupertinoThemeData(brightness: brightness),
        ),
        child: CupertinoActivityIndicator(radius: radius ?? 10));
  }
}
