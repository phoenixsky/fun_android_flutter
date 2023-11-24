import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final _scrollController = ScrollController();

  get scrollController => _scrollController;

  final bannerHeight = Get.height * 0.25;

  /// AppBar是否是收缩状态。用来控制AppBar的Title和Button，以及FloatingBar的显示
  final isAppBarCollapsed = false.obs;

  @override
  void onInit() {
    super.onInit();

    _scrollController.addListener(() {
      if (_scrollController.offset > bannerHeight - kToolbarHeight) {
        isAppBarCollapsed.value = true;
      } else {
        isAppBarCollapsed.value = false;
      }
    });
  }
}
