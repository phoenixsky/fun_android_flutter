import 'package:fun_android/config/storage_manager.dart';
import 'package:fun_android/provider/base_model.dart';
import 'package:fun_android/provider/view_state.dart';
import 'package:fun_android/service/wan_android_repository.dart';

import 'user_model.dart';

const String kLoginName = 'kLoginName';

class LoginModel extends BaseModel {
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null) {
    viewState = ViewState.idle;
  }

  String getLoginName() {
    return StorageManager.sharedPreferences.getString(kLoginName);
  }

  Future<bool> login(loginName, password) async {
    setBusy(true);
    try {
      var user = await WanAndroidRepository.login(loginName, password);
      userModel.saveUser(user);
      StorageManager.sharedPreferences
          .setString(kLoginName, userModel.user.username);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy(true);
    try {
      await WanAndroidRepository.logout();
      userModel.clearUser();
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }
}
