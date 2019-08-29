import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdAppUtils {
  static Future<String> canOpenApp(url) async {
    Uri uri = Uri.parse(url);
    var scheme;
    switch (uri.host) {
      case 'www.jianshu.com': //简书
        scheme = 'jianshu://${uri.pathSegments.join("/")}';
        break;
      case 'juejin.im': //掘金
        /// 原始链接:https://juejin.im/post/5d66565cf265da03e71b0672
        /// App链接:juejin://post/5d66565cf265da03e71b0672
        scheme = 'juejin://${uri.pathSegments.join("/")}';
        break;
      default:
//        throw 'Could not launch $url';
        break;
    }
    return scheme;
//    canLaunch暂时无效
//    if (await canLaunch(scheme)) {
//      return scheme;
//    }
  }

  ///    url = 'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
  ///    url = 'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
  ///    url = 'sms:5550101234';
  ///    url = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
  ///    url = 'jianshu://p/faf175c66c91';
  ///    url = 'youtube://';
  static openAppByUrl(url) async {
    await launch(url);
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
  }
}
