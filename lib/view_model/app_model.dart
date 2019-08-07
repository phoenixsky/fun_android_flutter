import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 主要用于app启动相关
class AppModel with ChangeNotifier {

  static const firstEntry = 'firstEntry';

  bool isFirst = false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(firstEntry);
    notifyListeners();
  }


}
