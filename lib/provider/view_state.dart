enum ViewState { idle, busy, empty, error, unAuthorized }

//enum ConnectivityStatus { WiFi, Cellular, Offline }

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
