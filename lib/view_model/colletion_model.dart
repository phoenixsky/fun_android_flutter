import 'package:flutter/material.dart';
import 'package:wan_android/config/net/api.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/provider/view_state.dart';
import 'package:wan_android/service/wan_android_repository.dart';

import 'login_model.dart';

class CollectionListModel extends BaseListModel<Article> {
  LoginModel loginModel;

  CollectionListModel({this.loginModel});

  @override
  Future<List<Article>> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchCollectList(pageNum);
  }

  @override
  void setUnAuthorized() {
    loginModel.logout();
    super.setUnAuthorized();
  }
}

class CollectionModel extends BaseModel {
  final Article article;
  final CollectionAnimationModel animationModel;

  CollectionModel(this.article, {this.animationModel}) {
    viewState = ViewState.idle;
  }

  collect() async {
    setBusy(true);
    try {
      // article.collect 字段为null,代表是从我的收藏页面进入的 需要调用特殊的取消接口
      if (article.collect == null) {
        await WanAndroidRepository.unMyCollect(
            id: article.id, originId: article.originId);
      } else {
        if (article.collect) {
          await WanAndroidRepository.unCollect(article.id);
        } else {
          await WanAndroidRepository.collect(article.id);
          animationModel?.play();
        }
      }
      article.collect = !(article.collect ?? true);
      setBusy(false);
    } on DioError catch (e) {
      if (e.error is UnAuthorizedException) {
        setUnAuthorized();
      } else {
        debugPrint(e.toString());
        setError(e is Error ? e.toString() : e.message);
      }
    } catch (e) {
      print(e.toString());
      setError(e.toString());
    }
  }
}

class CollectionAnimationModel extends ChangeNotifier {
  /// 正在播放动画
  bool playing = false;

  play() {
    if (!playing) {
      playing = true;
      notifyListeners();
    }
  }

  pause() {
    if (playing) {
      playing = false;
      notifyListeners();
    }
  }
}
