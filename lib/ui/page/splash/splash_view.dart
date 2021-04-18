import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:funflutter_wandroid/extension/asset_wrapper.dart';

import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  final SplashLogic logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        // 防止android用户点击返回退出
        onWillPop: () => Future.value(false),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
                Get.isDarkMode
                    ? "splash_bg.png".assetImgUrl()
                    : "splash_bg_dark.png".assetImgUrl(),
                fit: BoxFit.fill),
            AnimatedFlutterLogo(animation: logic.animation),
            AnimatedAndroidLogo(animation: logic.animation),
            NextButton()
          ],
        ),
      ),
    );
  }
}

// flutter logo
class AnimatedFlutterLogo extends AnimatedWidget {
  AnimatedFlutterLogo({
    required Animation<double> animation,
  }) : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: Duration(milliseconds: 10),
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      curve: Curves.bounceOut,
      child: Image.asset(
        "splash_flutter.png".assetImgUrl(),
        width: 280,
        height: 120,
      ),
    );
  }
}

// fun android logo
class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({
    required Animation<double> animation,
  }) : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'splash_fun.png'.assetImgUrl(),
            width: 140 * (1 - animation.value),
            height: 80 * (1 - animation.value),
          ),
          Image.asset(
            'splash_android.png'.assetImgUrl(),
            width: 200 * (animation.value),
            height: 80 * (animation.value),
          ),
        ],
      ),
    );
  }
}

/// 跳过按钮
class NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashLogic logic = Get.find();
    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        child: InkWell(
          onTap: logic.nextPage,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              margin: EdgeInsets.only(right: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black.withAlpha(100),
              ),
              child: Obx(() => Text("跳过 ${logic.counter}"))),
        ),
      ),
    );
  }
}
