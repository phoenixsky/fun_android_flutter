import 'dart:convert';
import 'dart:ui';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_unescape/html_unescape.dart';

class StatusBarUtils {

  /// 根据主题色彩控制状态栏字体颜色
  /// 通过AnnotatedRegion<SystemUiOverlayStyle>实现
  static systemUiOverlayStyle(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
  }
}
