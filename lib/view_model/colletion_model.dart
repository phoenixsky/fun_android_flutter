import 'package:flutter/material.dart';
import 'package:fun_android/config/net/api.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/provider/view_state_refresh_list_model.dart';
import 'package:fun_android/provider/view_state_model.dart';
import 'package:fun_android/provider/view_state.dart';
import 'package:fun_android/service/wan_android_repository.dart';

import 'login_model.dart';

class CollectionListModel extends ViewStateRefreshListModel<Article> {
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

class CollectionModel extends ViewStateModel {
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
          animationModel?.play(false);
        } else {
          await WanAndroidRepository.collect(article.id);
          animationModel?.play(true);
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
  bool _playing = false;
  bool _like = true;

  get like => _like;

  get playing => _playing;

  play(bool like) {
    if (!_playing) {
      _playing = true;
      _like = like;
      notifyListeners();
    }
  }

  pause() {
    if (_playing) {
      _playing = false;
      notifyListeners();
    }
  }
}
