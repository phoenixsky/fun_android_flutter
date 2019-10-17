import 'package:fun_android/config/net/api.dart';
import 'package:fun_android/provider/view_state_model.dart';

/// 页面状态类型
enum ViewState {
  idle,
  busy, //加载中
  empty, //无数据
  error, //加载失败
  unAuthorized, //未登录
}

/// 错误类型
enum ErrorType {
  defaultError,
  networkError,
}

class ViewStateError {
  ErrorType _type = ErrorType.defaultError;
  String _message;
  String _errorMessage;

  ViewStateError(e, {String message, StackTrace stackTrace}) {
//    if(e is String){
//      _errorMessage = e;
//    } else if (e is Error) {//错误类型
//      _errorMessage = e.toString();
//    } else { //exception
//      _errorMessage = e.message;
//    }
    printErrorStack(e, stackTrace);
    _errorMessage = e.toString();
    _message = message;
    if (e is DioError) {
      _type = ErrorType.networkError;
    }
  }

  ErrorType get errorType => _type;

  String get message => _message ?? _errorMessage;

  String get errorMessage => _errorMessage;

  @override
  String toString() {
    return 'ViewStateError{_errorType: $_type, _message: $_message, _errorMessage: $_errorMessage}';
  }
}

//enum ConnectivityStatus { WiFi, Cellular, Offline }

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
