import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:funflutter_wandroid/ui/router/app_pages.dart';
import 'package:get/get.dart';

class SplashLogic extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _logoController;
  late Animation<double> animation;

  @override
  void onInit() {
    // logo
    _logoController =
        AnimationController(vsync: this, duration: 1500.milliseconds);
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController)
          ..addStatusListener((status) {
            animation.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _logoController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                _logoController.forward();
              }
            });
          }));
    _logoController.forward();
    super.onInit();
  }

  @override
  void onClose() {
    _logoController.dispose();
    super.onClose();
  }

  nextPage() {
    // off关掉路由的方式,会自动触发onClose
    Get.offNamed(AppRoutes.HOME);
  }
}
