import 'package:flutter/material.dart';

import 'package:wan_android/provider/view_state.dart';

class BaseModel with ChangeNotifier {
  ViewState _viewState;
  String _errorMessage;

  String get errorMessage => _errorMessage;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  bool get busy => _viewState == ViewState.busy;

  bool get idle => _viewState == ViewState.idle;

  void setBusy(bool value) {
    _errorMessage = null;
    setViewState(value ? ViewState.busy : ViewState.idle);
  }

  bool get empty => _viewState == ViewState.empty;

  void setEmpty() {
    _errorMessage = null;
    setViewState(ViewState.empty);
  }

  bool get unAuthorized => _viewState == ViewState.unAuthorized;

  void setUnAuthorized() {
    _errorMessage = null;
    setViewState(ViewState.unAuthorized);
  }

  bool get error => _viewState == ViewState.error;

  void setError(String message) {
    _errorMessage = message;
    setViewState(ViewState.error);
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $_viewState, _errorMessage: $_errorMessage}';
  }
}
