import 'view_state_model.dart';

/// 基于
abstract class ViewStateListModel<T> extends ViewStateModel {
  /// 页面数据
  List<T> list = [];

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy();
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      list.clear();
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        onCompleted(data);
        list.addAll(data);
        setIdle();
      }
    } catch (e, s) {
      handleException(e, s);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}
}
