import 'package:funflutter_wandroid/entity/banner_entity.dart';
import 'package:funflutter_wandroid/generated/json/base/json_convert_content.dart';
import 'package:funflutter_wandroid/net/client/wandroid_http_client.dart';


/// @author phoenixsky
/// @date 4/26/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

class WandroidAPI {
  // 轮播
  static Future<List<BannerEntity>> fetchBanners() async {
    final resp = await http.get('banner/json');
    return JsonConvert.fromJsonAsT<List<BannerEntity>>(resp.data);
  }

  // 测试接口错误
  static Future<List<BannerEntity>> fetchBannersError() async {
    final resp = await http.get('banner/json');
    return JsonConvert.fromJsonAsT<List<BannerEntity>>(resp.data);
  }

  // 轮播
  static Future login(String username, String password) async {
    final resp = await http.post('user/login', queryParameters: {
      'username': username,
      'password': password,
    });
  }
}
