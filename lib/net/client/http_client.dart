/// @author phoenixsky
/// @date 4/25/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:funflutter_wandroid/generated/json/base/json_convert_content.dart';
import 'package:funflutter_wandroid/utils/log_utils.dart';

const _tag = "HttpClient";

/// 支持多实例的dio扩展类
/// 可支持多个api服务商,
abstract class BaseHttpClient extends DioForNative {
  /// 构造方法处理一些默认参数
  BaseHttpClient() {
    _beforeInit();
    onInit();
    _afterInit();
  }

  void _beforeInit() {
    (transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
    // 第一个拦截器,打印未经过处理的response数据
    interceptors.add(OriginInterceptor());
    interceptors.add(HeaderInterceptor());
  }

  void onInit() {}

  void _afterInit() {
    /// LogInterceptor 需要添加到队尾,interceptors的结构为FIFO
    interceptors.add(EasyLogInterceptor());
  }
}

/// 添加常用Header
class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = 1000 * 15;
    options.receiveTimeout = 1000 * 45;

    /// 配置一些app的公共头:
    /// options.headers["User-Agent"] = ""
    super.onRequest(options, handler);
  }
}

/// LogInterceptor
class EasyLogInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    logDebug('----------start----------', tag: _tag);

    if (options.queryParameters.isEmpty) {
      logDebug('RequestUrl: ${options.baseUrl + options.path}', tag: _tag);
    } else {
      logDebug(
          'RequestUrl: ${options.baseUrl + options.path}?${Transformer.urlEncodeMap(options.queryParameters)}',
          tag: _tag);
    }

    logDebug('RequestMethod: ${options.method}', tag: _tag);
    if (options.headers.length > 0)
      logDebug('RequestHeaders: ${options.headers}', tag: _tag);
    if (options.contentType != null) {
      logDebug('RequestContentType: ${options.contentType}', tag: _tag);
    }
    if (options.data != null) {
      logDebug('RequestData: ${options.data}', tag: _tag);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    // logDebug('------------------- ProcessedResponseData -------------------');
    // logJson('${response.data}', tag: _tag);
    super.onResponse(response, handler);
    logDuration();
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _endTime = DateTime.now();
    super.onError(err, handler);
    logDuration();
  }

  logDuration() {
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    logDebug('----------End: $duration 毫秒----------', tag: _tag);
  }
}

class OriginInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.responseType == ResponseType.json) {
      logDebug(
          '↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ OriginResponseData ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓\n\n'
          '${json.encode(response.data)}'
          '\n\n↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ OriginResponseData ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑',
          tag: _tag);
    }
    handler.next(response);
  }
}

/// 基础响应类
///
abstract class BaseResponseEntity<T> {
  late int code;
  late String message;
  late T data;

  /// 是否响应成功
  bool get success;

  /// 需要安装FlutterJsonBeanFactory
  T generateOBJ<O>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }

  @override
  String toString() {
    return 'BaseResponseEntity{code: $code, message: $message, data: $data}';
  }
}

_parseJson(String data) {
  /// 使用compute条件 数据长度大于10k
  /// 经测试发现compute在后台解码json耗时比直接解码慢很多,这里做个估值判断
  if (data.length > 1024 * 10) {
    return compute(_jsonDecode, data);
  } else {
    return jsonDecode(data);
  }
}

/// 将json字符串转为对象类型
/// 必须是顶层函数
_jsonDecode(String response) {
  return jsonDecode(response);
}
