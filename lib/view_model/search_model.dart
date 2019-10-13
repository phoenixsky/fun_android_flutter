import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fun_android/model/search.dart';
import 'package:fun_android/provider/view_state_refresh_list_model.dart';
import 'package:fun_android/provider/view_state_list_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

const String kLocalStorageSearch = 'kLocalStorageSearch';
const String kSearchHotList = 'kSearchHotList';
const String kSearchHistory = 'kSearchHistory';

class SearchHotKeyModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    LocalStorage localStorage = LocalStorage(kLocalStorageSearch);
//    localStorage.deleteItem(keySearchHotList);//测试没有缓存
    await localStorage.ready;
    List localList = (localStorage.getItem(kSearchHotList) ?? []).map<SearchHotKey>((item) {
      return SearchHotKey.fromMap(item);
    }).toList();

    if (localList.isEmpty) {
      //缓存为空,需要同步加载网络数据
      List netList = await WanAndroidRepository.fetchSearchHotKey();
      localStorage.setItem(kSearchHotList, netList);
      return netList;
    } else {
//      localList.removeRange(0, 3);//测试缓存与网络数据不一致
      WanAndroidRepository.fetchSearchHotKey().then((netList) {
        netList = netList ?? [];
        if (!ListEquality().equals(netList, localList)) {
          list = netList;
          localStorage.setItem(kSearchHotList, list);
          setIdle();
        }
      });
      return localList;
    }
  }

  shuffle(){
    list.shuffle();
    notifyListeners();
  }

}

class SearchHistoryModel extends ViewStateListModel<String> {
  clearHistory() async {
    debugPrint('clearHistory');
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(kSearchHistory);
    list.clear();
    setEmpty();
  }

  addHistory(String keyword) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var histories = sharedPreferences.getStringList(kSearchHistory) ?? [];
    histories
      ..remove(keyword)
      ..insert(0, keyword);
    await sharedPreferences.setStringList(kSearchHistory, histories);
    notifyListeners();
  }

  @override
  Future<List<String>> loadData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(kSearchHistory) ?? [];
  }
}

class SearchResultModel extends ViewStateRefreshListModel {
  final String keyword;
  final SearchHistoryModel searchHistoryModel;

  SearchResultModel({this.keyword, this.searchHistoryModel});

  @override
  Future<List> loadData({int pageNum}) async {
    if (keyword.isEmpty) return [];
    searchHistoryModel.addHistory(keyword);
    return await WanAndroidRepository.fetchSearchResult(
        key: keyword, pageNum: pageNum);
  }
}
