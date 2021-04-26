import 'package:bot_toast/bot_toast.dart';
import 'package:funflutter_wandroid/net/api/wandroid_api.dart';
import 'package:funflutter_wandroid/net/net.dart';
import 'package:funflutter_wandroid/utils/log_utils.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    var banners = await WandroidAPI.fetchBanners();
    var imagePath = banners[0].imagePath;
  }

  fetchBanners() async {
    try {
      var list = await WandroidAPI.fetchBannersError();
      // do something
    } on DioError catch (e) {
      if (e.error is UnAuthorizedException) {
        BotToast.showText(text: "未授权");
        logError(e);
      } else {
        BotToast.showText(text: e.netException.message);
        logError(e);
      }
    }
  }

  login() async {
    await WandroidAPI.login("wuwuhaha", "wuwuhaha");
  }
}
