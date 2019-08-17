import 'package:flutter/material.dart';

import 'package:wan_android/provider/view_state.dart';

class BaseModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  ViewState viewState = ViewState.busy;
  String _errorMessage;

  String get errorMessage => _errorMessage;

  setViewState(ViewState viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  void setBusy(bool value) {
    _errorMessage = null;
    setViewState(value ? ViewState.busy : ViewState.idle);
  }

  bool get empty => viewState == ViewState.empty;

  void setEmpty() {
    _errorMessage = null;
    setViewState(ViewState.empty);
  }

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  void setUnAuthorized() {
    _errorMessage = null;
    setViewState(ViewState.unAuthorized);
  }

  bool get error => viewState == ViewState.error;

  void setError(String message) {
    _errorMessage = message;
    setViewState(ViewState.error);
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _errorMessage: $_errorMessage}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
