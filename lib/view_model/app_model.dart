import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fun_android/provider/view_state_model.dart';
import 'package:fun_android/service/app_repository.dart';
import 'package:fun_android/utils/platform_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppFirstEntry = 'kAppFirstEntry';

// 主要用于app启动相关
class AppModel with ChangeNotifier {
  bool isFirst = false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class AppUpdateModel extends ViewStateModel {
  checkUpdate() async {
    String url;
    setBusy(true);
    try {
      var appVersion = await PlatformUtils.getAppVersion();
      url =
          await AppRepository.checkUpdate(Platform.operatingSystem, appVersion);
      setBusy(false);
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
    }
    return url;
  }
}
