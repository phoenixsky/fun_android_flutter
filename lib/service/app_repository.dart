import 'package:flutter/cupertino.dart';
import 'package:fun_android/config/net/lean_cloud_api.dart';

/// App相关接口
class AppRepository {
  static Future checkUpdate(String platform, String version) async {
    var response = await http.get('classes/appVersion',
        queryParameters: {'where': '{"platform":"$platform"}'});
    var result = response.data[0];
    debugPrint('当前版本为===>$version');
    if (result['version'] != version) {
      debugPrint('发现新版本===>${result['version']}\nurl:${result['url']}');
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
