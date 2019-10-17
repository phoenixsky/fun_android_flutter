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
    printErrorStack(e, stackTrace);
    _errorMessage = e.toString();
    _message = message;

    if (e is DioError) {
      _type = ErrorType.networkError;
      if (e.error is NotSuccessException) {
        _type = ErrorType.defaultError;
        _message = e.error.message;
      }
    }
  }

  ErrorType get errorType => _type;

  String get message => _message ?? _errorMessage;

  String get errorMessage => _errorMessage;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  get isNetworkError => _type == ErrorType.networkError;

  @override
  String toString() {
    return 'ViewStateError{_errorType: $_type, _message: $_message, _errorMessage: $_errorMessage}';
  }
}

//enum ConnectivityStatus { WiFi, Cellular, Offline }

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseRespData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
