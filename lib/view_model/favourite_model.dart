import 'package:fun_android/model/article.dart';
import 'package:fun_android/provider/view_state_refresh_list_model.dart';
import 'package:fun_android/provider/view_state_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

import 'login_model.dart';

/// 我的收藏列表
class FavouriteListModel extends ViewStateRefreshListModel<Article> {
  LoginModel loginModel;

  FavouriteListModel({this.loginModel});

  @override
  void setUnAuthorized() {
    loginModel.logout();
    super.setUnAuthorized();
  }

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchCollectList(pageNum);
  }
}

/// 收藏/取消收藏
class FavouriteModel extends ViewStateModel {

  collect(Article article) async {
    setBusy(true);
    try {
//      await Future.delayed(Duration(seconds: 2));
      // article.collect 字段为null,代表是从我的收藏页面进入的 需要调用特殊的取消接口
      if (article.collect == null) {
        await WanAndroidRepository.unMyCollect(
            id: article.id, originId: article.originId);
      } else {
        if (article.collect) {
          await WanAndroidRepository.unCollect(article.id);
        } else {
          await WanAndroidRepository.collect(article.id);
        }
      }
      article.collect = !(article.collect ?? true);
      setBusy(false);
    } catch (e, s) {
      handleCatch(e, s);
    }
  }
}



