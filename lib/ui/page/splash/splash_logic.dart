import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:funflutter_wandroid/ui/router/app_pages.dart';
import 'package:get/get.dart';

class SplashLogic extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _logoController;
  late Animation<double> animation;

  // 默认三秒开屏动画
  var counter = 3.obs;
  late Timer _timer;

  @override
  void onInit() {
    // logo
    _logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    _logoController.forward();

    // 倒计时
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      counter--;
      if (counter.value == 0) {
        nextPage();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    _logoController.dispose();
    super.onClose();
  }

  nextPage() {
    // off关掉路由的方式,会自动触发onClose
    Get.offNamed(AppRoutes.HOME);
  }
}
