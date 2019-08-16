import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/provider/view_state.dart';
import 'package:wan_android/service/wan_android_repository.dart';

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
      setError(e.message ?? e.toString());
      return false;
    }
  }
}
