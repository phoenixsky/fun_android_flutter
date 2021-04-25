import 'package:funflutter_wandroid/entity/banner_entity.dart';
import 'package:funflutter_wandroid/net/client/wandroid_http_client.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchBanner() async {
    var resp = await http.get<List<BannerEntity>>('banner/json');
    resp.data?.forEach((i) => print(i));
  }
}
