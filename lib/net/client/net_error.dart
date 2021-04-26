import 'dart:io';

import 'package:dio/dio.dart';
import 'package:funflutter_wandroid/utils/log_utils.dart';

/// @author phoenixsky
/// @date 4/26/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter
///

extension DioErrorExtension on DioError {
  NetException get netException {
    if (type == DioErrorType.connectTimeout ||
        type == DioErrorType.sendTimeout ||
        type == DioErrorType.receiveTimeout ||
        type == DioErrorType.cancel) {
      return TimeoutNetException(error.toString(), type);
    } else if (type == DioErrorType.response) {
      return NetException(error.toString(), code: response!.statusCode!);
    } else if (type == DioErrorType.other) {
      if (error is! NetException) {
        return NetException(error.toString());
      }
      return error;
    }
    return NetException("未知异常");
  }
}

class NetException implements Exception {
  NetException(this.message, {this.code = -1});

  final int code;
  final String message;

  @override
  String toString() {
    return 'NetException{code: $code, msg: $message}';
  }
}

/// 超时异常
class TimeoutNetException extends NetException {
  final DioErrorType type;

  TimeoutNetException(String msg, this.type) : super(msg);
}

/// 接口的code没有返回为true的异常
class NotSuccessNetException extends NetException {
  NotSuccessNetException(int code, String msg) : super(msg, code: code);
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException extends NetException {
  UnAuthorizedException({String msg = "UnAuthorizedException"}) : super(msg);
}
