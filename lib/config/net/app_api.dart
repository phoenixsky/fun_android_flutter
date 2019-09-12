import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    interceptors.add(AppApiInterceptor());
  }
}

/// App相关 API
class AppApiInterceptor extends InterceptorsWrapper {
  static const baseUrl = 'http://192.168.1.31:8088';

  @override
  onRequest(RequestOptions options) {
    options.baseUrl = baseUrl;
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
//    debugPrint('---api-request--->data--->${options.data}');
    return options;
  }
}
