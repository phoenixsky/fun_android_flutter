import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'http.dart';
export 'package:dio/dio.dart';

class ApiInterceptor extends InterceptorsWrapper {
  static const baseUrl = 'https://www.wanandroid.com/';

  @override
  onRequest(RequestOptions options) {
    options.baseUrl = baseUrl;
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
//    debugPrint('---api-request--->data--->${options.data}');
    return options;
  }

  @override
  onResponse(Response response) {
    var statusCode = response.statusCode;
    if (statusCode != 200) {
      /// 非200会在http的onError()中
    } else {
//      debugPrint('---api-response--->resp----->${response.data}');
      if (response.data is Map) {
        RespData respData = RespData.fromJson(response.data);
        if (respData.success) {
          response.data = respData.data;
          return http.resolve(response);
        } else {
          return handleFailed(respData);
        }
      } else {
        /// WanAndroid API 如果报错,返回的数据类型存在问题
        /// eg: 没有登录的返回的值为'{"errorCode":-1001,"errorMsg":"请先登录！"}'
        /// 虽然是json样式,但是[response.headers.contentType?.mimeType]的值为'text/html'
        /// 导致dio没有解析为json对象.两种解决方案:
        /// 1.在post/get方法前加入泛型(Map),让其强制转换
        /// 2.在这里统一处理再次解析
        debugPrint('---api-response--->error--not--map---->$response');
        RespData respData = RespData.fromJson(json.decode(response.data));
        return handleFailed(respData);
      }
    }
  }

  Future<Response> handleFailed(RespData respData) {
    debugPrint('---api-response--->error---->$respData');
    if (respData.code == -1001) {
      // 需要登录
      throw const UnAuthorizedException();
    }
    return http.reject(respData.message);
  }
}

class RespData {
  dynamic data;
  int code = 0;
  String message;

  bool get success => 0 == code;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.code;
    data['errorMsg'] = this.message;
    data['data'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}

class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
