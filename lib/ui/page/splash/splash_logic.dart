import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../tab_main/tab_main_view.dart';

class SplashLogic extends GetxController with GetTickerProviderStateMixin {
  final _countDown = 5.obs;

  // 依然可以响应式
  get jumpButtonText => "${_countDown.value} / 跳过";

  late RxDouble logoAnimation;

  late AnimationController _animationController;

  @override
  void onInit() {
    // 动画初始化
    _initAnimation();
    // 倒计时
    _startCountDown(onFinish: () {
      navigationMain();
    });
  }

  @override
  void onClose() {
    _animationController.dispose();
  }

  void _initAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Curves.easeInOutBack, parent: _animationController));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    logoAnimation = animation.value.obs;
    animation.addListener(() {
      // 将动画的值给到响应式
      logoAnimation.value = animation.value;
    });
    _animationController.forward();
  }

  void _startCountDown({required Function onFinish}) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown.value > 1) {
        _countDown.value--;
      } else {
        timer.cancel();
        onFinish();
      }
    });
  }

  void navigationMain() {
    _animationController.dispose();
    Get.off(() => TabMainPage());
  }
}
