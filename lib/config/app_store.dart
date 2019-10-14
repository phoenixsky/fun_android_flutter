import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fun_android/utils/platform_utils.dart';

import 'net/lean_cloud_api.dart';

var isReviewing = true;

/// 是否在审核期间
bool get appStoreReview {
  return Platform.isIOS ? isReviewing : false;
}

/// 或者正在审核字段 1:正在审核
Future fetchReviewState() async {
  if (!Platform.isIOS) {
    isReviewing = false;
    return;
  }
  // 该日期后不再审核
  if (DateTime.now().isAfter(DateTime(2019, 10, 20, 9, 30))) {
    isReviewing = false;
    return;
  }
  // 设置过审核结束后,就无需再进入了
  if (!isReviewing) return;
  var version = await PlatformUtils.getAppVersion();
  var response = await http.get<List>('classes/appVersion', queryParameters: {
    'where': '{"platform": "appStore", "version": "$version"}'
  });
  if (response.data.length > 0) {
    var result = response.data[0]['url'];
    isReviewing = result == '1';
  }
  debugPrint('是否正在review:$isReviewing');
}

/// 替换android字符
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
