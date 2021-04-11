import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:html_unescape/html_unescape.dart';

class StringUtils {
  static String toMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }

  static String urlDecoder(String data) {
    return data == null ? null : HtmlUnescape().convert(data);
  }

  static String removeHtmlLabel(String data) {
    return data?.replaceAll(RegExp('<[^>]+>'), '');
  }
}
