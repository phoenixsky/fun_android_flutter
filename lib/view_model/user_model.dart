import 'package:wan_android/model/user.dart';
import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class UserModel extends BaseModel {
  User _user;

  User get user => _user;

  bool get isLogin => user != null;

  Future<bool> login(loginName, password) async {
    setBusy(true);
    try {
      _user = await WanAndroidRepository.login(loginName, password);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    setBusy(true);
    try {
      await WanAndroidRepository.logout();
      _user = null;
      setBusy(false);
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }
}
