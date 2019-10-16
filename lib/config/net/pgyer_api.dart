import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://www.pgyer.com/apiv2/';
    interceptors.add(PgyerApiInterceptor());
  }
}

/// App相关 API
class PgyerApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.queryParameters['_api_key'] = '00f25cece8e201753872c268b5832df9';
    options.queryParameters['appKey'] = '7954deb7bce815d3b49a0626ff0b76a7';

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

  /// 需要指定接口在什么条件下返回成功
  bool get success => code == 0;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}

/// CheckApp更新接口
class AppUpdateInfo {
  String buildBuildVersion;
  String forceUpdateVersion;
  String forceUpdateVersionNo;
  bool needForceUpdate;
  String downloadURL;
  bool buildHaveNewVersion;
  String buildVersionNo;
  String buildVersion;
  String buildShortcutUrl;
  String buildUpdateDescription;

  static AppUpdateInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AppUpdateInfo pgyerApiBean = AppUpdateInfo();
    pgyerApiBean.buildBuildVersion = map['buildBuildVersion'];
    pgyerApiBean.forceUpdateVersion = map['forceUpdateVersion'];
    pgyerApiBean.forceUpdateVersionNo = map['forceUpdateVersionNo'];
    pgyerApiBean.needForceUpdate = map['needForceUpdate'];
    pgyerApiBean.downloadURL = map['downloadURL'];
    pgyerApiBean.buildHaveNewVersion = map['buildHaveNewVersion'];
    pgyerApiBean.buildVersionNo = map['buildVersionNo'];
    pgyerApiBean.buildVersion = map['buildVersion'];
    pgyerApiBean.buildShortcutUrl = map['buildShortcutUrl'];
    pgyerApiBean.buildUpdateDescription = map['buildUpdateDescription'];
    return pgyerApiBean;
  }

  Map toJson() => {
    "buildBuildVersion": buildBuildVersion,
    "forceUpdateVersion": forceUpdateVersion,
    "forceUpdateVersionNo": forceUpdateVersionNo,
    "needForceUpdate": needForceUpdate,
    "downloadURL": downloadURL,
    "buildHaveNewVersion": buildHaveNewVersion,
    "buildVersionNo": buildVersionNo,
    "buildVersion": buildVersion,
    "buildShortcutUrl": buildShortcutUrl,
    "buildUpdateDescription": buildUpdateDescription,
  };
}