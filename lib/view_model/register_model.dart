import 'package:fun_android/provider/view_state_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

class RegisterModel extends ViewStateModel {

  Future<bool> singUp(loginName, password, rePassword) async {
    setBusy();
    try {
      await WanAndroidRepository.register(loginName, password, rePassword);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }
}
