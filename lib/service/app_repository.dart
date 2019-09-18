import 'package:flutter/cupertino.dart';
import 'package:fun_android/config/net/lean_cloud_api.dart';

/// App相关接口
class AppRepository {
  // 轮播
  static Future checkUpdate(String platform, String version) async {
    var response = await http.get('classes/appVersion',
        queryParameters: {'where': '{"platform":"$platform"}'});
    var result = response.data[0];
    debugPrint('当前版本为===>$version');
    debugPrint('最新版本为===>${result['version']}');
    if (result['version'] != version) {
      return result['url'];
    }
    return null;
  }

  /// AppStore Review
  static Future isReview(String version) async {
    var response = await http.get('appStoreReview', queryParameters: {
      'version': version,
    });
    return response.data['review'];
  }
}
