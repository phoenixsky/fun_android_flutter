import 'package:fun_android/provider/base_model.dart';
import 'package:fun_android/provider/view_state.dart';
import 'package:fun_android/service/wan_android_repository.dart';

class RegisterModel extends BaseModel {
  RegisterModel() {
    viewState = ViewState.idle;
  }

  Future<bool> singUp(loginName, password, rePassword) async {
    setBusy(true);
    try {
      await WanAndroidRepository.register(loginName, password, rePassword);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }
}
