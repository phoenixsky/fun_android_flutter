import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/model/search.dart';
import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/provider/sample_list_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';

//class SearchHotKeyModel extends SampleListModel {
//  @override
//  Future<List> loadData() async {
//    return await WanAndroidRepository.fetchSearchHotKey() ?? [];
//  }
//}

class SearchHotKeyModel extends SampleListModel {
  static const String localStorageSearch = 'localStorageSearch';
  static const String keySearchHotList = 'keySearchHotList';

  @override
  Future<List> loadData() async {
    LocalStorage localStorage = LocalStorage(localStorageSearch);
//    localStorage.deleteItem(keySearchHotList);//测试没有缓存
    await localStorage.ready;
    List localList = (localStorage.getItem(keySearchHotList) ?? []).map((item) {
      return SearchHotKey.fromMap(item);
    }).toList();
    if (localList.isEmpty) {//缓存为空,需要同步加载网络数据
      List netList = await WanAndroidRepository.fetchSearchHotKey();
      localStorage.setItem(keySearchHotList, netList);
      return netList;
    } else {
//      localList.removeRange(0, 3);//测试缓存与网络数据不一致
      WanAndroidRepository.fetchSearchHotKey().then((netList) {
        netList = netList ?? [];
        if (!ListEquality().equals(netList, localList)) {
          list = netList;
          localStorage.setItem(keySearchHotList, list);
          setBusy(false);
        }
      });

      return localList;
    }
  }
}

class SearchHistoryModel extends SampleListModel<String> {
  static const String keySearchHistory = 'keySearchHistory';

  clearHistory() async {
    debugPrint('clearHistory');
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(keySearchHistory);
    list.clear();
    setEmpty();
  }

  addHistory(String keyword) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var histories = sharedPreferences.getStringList(keySearchHistory) ?? [];
    histories
      ..remove(keyword)
      ..insert(0, keyword);
    debugPrint('histories-->' + histories.toString());
    await sharedPreferences.setStringList(keySearchHistory, histories);
    notifyListeners();
  }

  @override
  Future<List<String>> loadData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(keySearchHistory) ?? [];
  }
}

class SearchResultModel extends BaseListModel {
  final String keyword;
  final SearchHistoryModel searchHistoryModel;

  SearchResultModel({this.keyword, this.searchHistoryModel});

  @override
  Future<List> loadData(int pageNum) async {
    if (keyword.isEmpty) return [];
    searchHistoryModel.addHistory(keyword);
    return await WanAndroidRepository.fetchSearchResult(
        key: keyword, pageNum: pageNum);
  }
}
