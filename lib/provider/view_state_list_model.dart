import 'package:flutter/foundation.dart';

import 'package:fun_android/provider/view_state_model.dart';

/// 基于
abstract class ViewStateListModel<T> extends ViewStateModel {
  List<T> list = [];

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy(true);
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        list = data;
        if (init) {
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      setError(e is Error ? e.toString() : e.message);
    }
  }

  // 加载数据
  Future<List<T>> loadData();
}
