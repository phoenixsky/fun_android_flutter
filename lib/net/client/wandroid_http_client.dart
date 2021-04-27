// @author phoenixsky
// @date 4/25/21
// @email moran.fc@gmail.com
// @github https://github.com/phoenixsky
// @group fun flutter

import 'package:funflutter_wandroid/net/client/http_client.dart';
import 'package:funflutter_wandroid/net/client/net_exception.dart';
import 'package:funflutter_wandroid/ui/page/login/login_view.dart';
import 'package:get/get.dart' hide Response;


const _tag = "WandroidHttpClient";
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
    options.headers['source'] = 'fun flutter wandroid';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var responseEntity = ResponseEntity.fromJson(response.data);
    if (responseEntity.success) {
      return handler.next(response..data = responseEntity.data);
    } else {
      var dioError =
          DioError(requestOptions: response.requestOptions, response: response);
      // 
      if (responseEntity.code == -1001) {
        // 理论上不应该在这里跳转UI
        Get.to(LoginPage(),
            transition: Transition.cupertino, fullscreenDialog: true);
        dioError.error = UnAuthorizedException();
        return handler.reject(dioError);
      }
      dioError.error =
          NotSuccessNetException(responseEntity.code, responseEntity.message);
      return handler.reject(dioError);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}

class ResponseEntity<T> extends BaseResponseEntity<T> {
  /// 根据业务类型,定制不同逻辑
  @override
  bool get success => code == 0;

  ResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
