import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://funandroid.phoenixsky.cn/1.1/';
    interceptors.add(LeanCloudApiInterceptor());
  }
}

/// App相关 API
class LeanCloudApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.headers['X-LC-Id'] = 'z3J5KBtLrbmeMAyo6D2uXobV-9Nh9j0Va';
    options.headers['X-LC-Key'] = 'nxHpvHda10VYhx7fIUv5sqFo';
    options.headers['Content-Type'] = 'application/json';

    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    return options;
  }

  @override
  onResponse(Response response) {
    RespData respData = RespData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      return http.reject(respData.message);
    }
  }
}

class RespData {
  dynamic data;
  int code;
  String message;

  bool get success => code == null;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.message;
    data['result'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['error'];
    data = json['results'];
  }
}
