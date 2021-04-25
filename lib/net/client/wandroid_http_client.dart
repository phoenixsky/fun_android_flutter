// @author phoenixsky
// @date 4/25/21
// @email moran.fc@gmail.com
// @github https://github.com/phoenixsky
// @group fun flutter

import 'package:dio/dio.dart';
import 'package:funflutter_wandroid/net/client/http_client.dart';

final Http http = Http();

class Http extends BaseHttpClient {
  @override
  void onInit() {
    options.baseUrl = 'https://www.wanandroid.com/';
    interceptors.add(ApiInterceptor());
    super.onInit();
  }
}

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['test'] = 'instap';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var responseEntity = ResponseEntity.fromJson(response.data);
    if (responseEntity.success) {
      response.data = responseEntity.data;
      return handler.next(response);
    } else {
      if (responseEntity.code == -1001) {
        handler.reject(DioError(requestOptions: response.requestOptions));
      }
    }
    super.onResponse(response, handler);
  }
}

class ResponseEntity<T> extends BaseResponseEntity<T> {
  /// 根据业务类型,定制不同逻辑
  @override
  bool get success => code == 0;

  ResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = generateOBJ<T>(json['data']);
  }
}
