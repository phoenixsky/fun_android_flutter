import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/config/net/api.dart';
import 'package:dio/dio.dart';


/// 基于
abstract class BaseListModel<T> extends BaseModel {
  static const int pageNumFirst = 0;
  static const int pageSize = 20;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  int _currentPageNum = pageNumFirst;

  List<T> list = [];

  /// 第一次进入页面loading skeleton
  init() async {
    setBusy(true);
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(pageNumFirst);
      if (data.isEmpty) {
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.resetNoData();
        }
        if (init) {
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
    } on DioError catch (e) {
      if(e.error is UnAuthorizedException){
        setUnAuthorized();
      }else{
        debugPrint(e.toString());
        setError(e.toString());
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      setError(e.toString());
    }
  }

  // 上拉加载更多
  loadMore() async {
    try {
      var data = await loadData(++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _currentPageNum--;
      refreshController.loadFailed();
    }
  }

  // 加载数据
  Future<List<T>> loadData(int pageNum);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
