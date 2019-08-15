import 'package:flutter/widgets.dart';
import 'package:wan_android/provider/base_model.dart';
import 'package:wan_android/provider/view_state.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class RegisterModel extends BaseModel {


  RegisterModel() {
    viewState = ViewState.idle;
  }

  String loginName;
  String password;
  String rePassword;

  Future<bool> singUp() async {
    setBusy(true);
    try {
      await WanAndroidRepository.register(loginName, password,rePassword);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }

}
