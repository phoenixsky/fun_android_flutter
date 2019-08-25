import 'package:flutter/cupertino.dart';
import 'package:fun_android/config/router_config.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/ui/widget/favourite_animation.dart';
import 'package:oktoast/oktoast.dart';

import 'dialog_helper.dart';

/// 收藏文章
/// 由于存在递归操作,所以抽取为方法,而且多出调用
///
/// 多个页面使用该方法,目前这种方式并不优雅,抽取位置有待商榷
addFavourites(context, model, tag) async {
  await model.collect();
  //未登录
  if (model.unAuthorized) {
    if (await DialogHelper.showLoginDialog(context)) {
      var success = await Navigator.pushNamed(context, RouteName.login);
      if (success ?? false) addFavourites(context, model, tag);
    }
  } else if (model.error) {
    //失败
    showToast(S.of(context).loadFailed);
  } else {
    ///接口调用成功播放动画
    Navigator.push(
        context,
        HeroDialogRoute(
            builder: (_) => FavouriteAnimationWidget(
                  tag: tag,
                  add: model.article.collect,
                )));
  }
}
