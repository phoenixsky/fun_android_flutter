import 'package:wan_android/config/net/api.dart';
import 'package:wan_android/config/storage_manager.dart';
import 'package:wan_android/model/user.dart';
import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/provider/view_state.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class UserModel extends BaseModel {
  static const String keyUser = 'keyUser';

  User _user;

  User get user => _user;

  bool get isLogin => user != null;

  UserModel() {
    viewState = ViewState.idle;
    var userMap = StorageManager.localStorage.getItem(keyUser);
    _user = userMap != null ? User.fromJsonMap(userMap) : null;
  }

  Future<bool> login(loginName, password) async {
    setBusy(true);
    try {
      _user = await WanAndroidRepository.login(loginName, password);
      StorageManager.localStorage.setItem(keyUser, _user);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    if (!isLogin) {
      //防止递归
      return false;
    }
    setBusy(true);
    try {
      _user = null;
      await WanAndroidRepository.logout();
      StorageManager.localStorage.deleteItem(keyUser);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }
}
