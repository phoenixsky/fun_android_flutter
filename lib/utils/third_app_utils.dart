import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdAppUtils {

  static Future<String> canOpenApp(url) async {
    await Future.delayed(Duration(seconds: 1));
    Uri uri = Uri.parse(url);
    var scheme;
    switch (uri.host) {
      case 'www.jianshu.com': //简书
        scheme = 'jianshu://${uri.pathSegments.join("/")}';
        break;
      default:
        throw 'Could not launch $url';
        break;
    }
    return scheme;
    // canLaunch暂时无效
//    if (await canLaunch(scheme)) {
//      return scheme;
//    }
  }

  static openAppByUrl(url) async {
    debugPrint(url);
//    url = 'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
//    url = 'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
//    url = 'sms:5550101234';
//    url = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
//    url = 'jianshu://p/faf175c66c91';
//    url = 'youtube://';
    await launch(url);
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
  }
}
