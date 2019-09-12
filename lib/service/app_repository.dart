import 'package:fun_android/config/net/app_api.dart';

/// App相关接口
class AppRepository {
  // 轮播
  static Future checkUpdate(String platform, String version) async {
    var response = await http.get('/checkUpdate', queryParameters: {
      'platform': platform,
      'version': version,
    });
    return response.data['url'];
  }

  /// AppStore Review
  static Future isReview(String version) async {
    var response = await http.get('/appStoreReview', queryParameters: {
      'version': version,
    });
    return response.data['review'];
  }
}
