import 'dart:io';

/// 是否在审核期间
bool get appStoreReview {
  return Platform.isIOS && DateTime.now().isBefore(DateTime(2019, 9, 3, 9, 30));
}

String replaceAndroid(String str) {
  if (appStoreReview) {
    return str
        .replaceAll(RegExp(r'wanandroid', caseSensitive: false), '学iOS')
        .replaceAll(RegExp(r'android', caseSensitive: false), 'iOS')
        .replaceAll('安卓', '苹果');
  }
  return str;
}

const String appleBannerUrl =
    'https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png';
