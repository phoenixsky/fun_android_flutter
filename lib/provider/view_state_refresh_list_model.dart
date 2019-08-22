import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fun_android/provider/view_state_model.dart';
import 'package:fun_android/config/net/api.dart';
import 'package:dio/dio.dart';

/// 基于
abstract class ViewStateRefreshListModel<T> extends ViewStateModel {
  static const int pageNumFirst = 0;
  static const int pageSize = 20;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  int _currentPageNum = pageNumFirst;

  List<T> list = [];

  /// 第一次进入页面loading skeleton
  Future<List<T>> initData() async {
    setBusy(true);
    return await refresh(init: true);
  }

  // 下拉刷新
  Future<List<T>> refresh({bool init = false}) async {
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
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        if (init) {
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
      return data;
    } on DioError catch (e) {
      if (e.error is UnAuthorizedException) {
        setUnAuthorized();
      } else {
        debugPrint(e.toString());
        setError(e.message);
      }
      return null;
    } catch (e, s) {
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      setError(e is Error ? e.toString() : e.message);
      return null;
    }
  }

  // 上拉加载更多
  Future<List<T>> loadMore() async {
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
      return data;
    } on DioError catch (e) {
      if (e.error is UnAuthorizedException) {
        setUnAuthorized();
      } else {
        debugPrint(e.toString());
        setError(e.message);
      }
      return null;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
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
