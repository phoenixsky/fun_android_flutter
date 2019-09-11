import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 由于app不管明暗模式,都是有底色
/// 所以将indicator颜色为亮色
class AppBarIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            cupertinoOverrideTheme:
                CupertinoThemeData(brightness: Brightness.dark)),
        child: CupertinoActivityIndicator());
  }
}
