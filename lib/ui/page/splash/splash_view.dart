import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:funflutter_wandroid/extension/assets_wrapper.dart';

import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  final SplashLogic logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    print("SplashPage build");
    return Scaffold(
      body: WillPopScope(
        // 防止android用户点击返回退出
        onWillPop: () => Future.value(false),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
                Get.isDarkMode
                    ? "splash_bg.png".assetsImgUrl
                    : "splash_bg_dark.png".assetsImgUrl,
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

/// 动画抽取,两个logo重用
Animation<double> useSplashAnimation() {
  print("useSplashAnimation");
  final animationController = useAnimationController(duration: 1.5.seconds);
  final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(curve: Curves.easeInOutBack, parent: animationController))
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  useEffect(() {
    print("useEffect");
    animationController.forward();
    return animationController.dispose;
  }, []);
  return animation;
}

// flutter logo
class AnimatedFlutterLogo extends AnimatedWidget {
  AnimatedFlutterLogo({
    required Animation<double> animation,
  }) : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    print("AnimatedFlutterLogo get build");
    return AnimatedAlign(
      duration: Duration(milliseconds: 10),
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      curve: Curves.bounceOut,
      child: Image.asset(
        "splash_flutter.png".assetsImgUrl,
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
            'splash_fun.png'.assetsImgUrl,
            width: 140 * (1 - animation.value),
            height: 80 * (1 - animation.value),
          ),
          Image.asset(
            'splash_android.png'.assetsImgUrl,
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
    var nextPage = Get.find<SplashLogic>().nextPage;
    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        child: InkWell(
            onTap: nextPage,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                margin: EdgeInsets.only(right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black.withAlpha(100),
                ),
                child: CountDownText(nextPage))
            // child: Obx(() => Text("跳过 ${logic.counter}"))),
            ),
      ),
    );
  }
}

/// 倒计时文本
/// 采用flutter-hook的方式来倒计时,可减少使用stateful后管理生命周期的部分代码量
class CountDownText extends HookWidget {
  final Function callback;

  CountDownText(this.callback);

  @override
  Widget build(BuildContext context) {
    var _counter = useState(3);
    useEffect(() {
      var timer = Timer.periodic(1.seconds, (timer) {
        _counter.value--;
        if (_counter.value == 0) {
          callback();
        }
      });
      return timer.cancel;
    }, const []);
    return Text(
      "跳过 | ${_counter.value}",
      style: TextStyle(color: Colors.white),
    );
  }
}
