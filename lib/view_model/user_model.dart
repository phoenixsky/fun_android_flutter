import 'package:flutter/cupertino.dart';
import 'package:fun_android/config/storage_manager.dart';
import 'package:fun_android/model/user.dart';

import 'favourite_model.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = 'kUser';

  GlobalFavouriteStateModel _globalFavouriteStateModel;

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromJsonMap(userMap) : null;
  }

  update(GlobalFavouriteStateModel globalFavouriteStateModel) {
    _globalFavouriteStateModel = globalFavouriteStateModel;
    notifyListeners();
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    _globalFavouriteStateModel.replaceAll(_user.collectIds);
    StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}
