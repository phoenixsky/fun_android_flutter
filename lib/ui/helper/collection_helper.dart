import 'package:flutter/cupertino.dart';
import 'package:fun_android/config/router_config.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/view_model/colletion_model.dart';
import 'package:oktoast/oktoast.dart';

import 'dialog_helper.dart';

/// 收藏文章
/// 由于存在递归操作,所以抽取为方法,而且多出调用
///
/// 多个页面使用该方法,目前这种方式并不优雅,抽取位置有待商榷
collectArticle(context, CollectionModel model) async {
  await model.collect();
  if (model.unAuthorized) {
    //未登录
    if (await DialogHelper.showLoginDialog(context)) {
      var success = await Navigator.pushNamed(context, RouteName.login);
      if (success ?? false) collectArticle(context, model);
    }
  } else if (model.error) {
    //失败
    showToast(S.of(context).loadFailed);
  }
}
