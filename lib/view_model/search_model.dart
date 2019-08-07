import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/model/search.dart';
import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/provider/sample_list_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class SearchHotKeyModel extends SampleListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchSearchHotKey();
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
    debugPrint('histories-->'+histories.toString());
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
    if(keyword.isEmpty) return [];
    searchHistoryModel.addHistory(keyword);
    return await WanAndroidRepository.fetchSearchResult(
        key: keyword, pageNum: pageNum);
  }
}
