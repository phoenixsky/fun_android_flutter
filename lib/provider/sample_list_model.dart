import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fun_android/provider/base_model.dart';

/// 基于
abstract class SampleListModel<T> extends BaseModel {
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
        list.clear();
        list.addAll(data);
        if (init) {
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      setError(e is Error ? e.toString() : e.message);
    }
  }

  // 加载数据
  Future<List<T>> loadData();
}
