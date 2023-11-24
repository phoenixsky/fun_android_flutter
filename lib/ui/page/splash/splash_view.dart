import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../asset.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    setupBars();
    return _splashContainer(
      children: [
        // 底部背景
        _buildBackgroundImage(),
        // logo动画
        _buildAnimationLogos(),
        // 跳过按钮
        _buildJumpButton(onClick: () => logic.navigationMain()),
      ],
    );
  }

  void setupBars() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent));
  }

  Widget _splashContainer({required List<Widget> children}) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: children,
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      Get.isDarkMode ? Images.splashDark : Images.splash,
    );
  }

  Widget _buildJumpButton({onClick}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 20.0,
        ),
        child: OutlinedButton(
          onPressed: onClick,
          child: Obx(() {
            return Text(logic.jumpButtonText);
          }),
        ),
      ),
    );
  }

  Widget _buildAnimationLogos() {
    return Obx(() {
      var animation = logic.logoAnimation.value;

      final funLogoSize = Size(200 * animation, 100 * animation);
      final wanLogoSize = Size(200 * (1 - animation), 100 * (1 - animation));

      // 夹带私货：注意同样是传宽高参数，上下两种方式不同。上边使用了Size这个提供的类
      // 这里使用了dart3.0的Records，其实也就是结构。个人觉得最佳食用方式为函数的多返回值
      // 可参看大喵的 https://juejin.cn/post/7194741144482218045#heading-1 有详细解释

      // 加key的方式。访问方式为:flutterLogoSize.with。
      // 个人推荐加key，因为这种方式更语义化，随着代码日益增长，一堆$1,$2，脑子都大了。话说为什么不是从0开始
      final flutterLogoSize = (width: 300 * animation, height: 140 * animation);
      // 不加key的方式，访问方式为:flutterLogoSize.$1
      final androidLogoSize = (300 * (1 - animation), 140 * (1 - animation));

      /**
       * 强迫症修正值
       */
      const fixOCD = 0.09;

      return Stack(
        fit: StackFit.expand,
        children: [
          _buildTopAnimationLogo(
            imagePath: Images.splashLogoFun,
            size: funLogoSize,
            alignment: Alignment(1 - animation + fixOCD, 0.25 * animation),
          ),
          _buildTopAnimationLogo(
            imagePath: Images.splashLogoWan,
            size: wanLogoSize,
            alignment:
                Alignment(animation * -1 - fixOCD, 0.25 * (1 - animation)),
          ),
          _buildBottomAnimationLogo(flutterLogoSize, androidLogoSize)
        ],
      );
    });
  }

  Widget _buildTopAnimationLogo({
    required String imagePath,
    required Size size,
    required Alignment alignment,
  }) {
    return AnimatedAlign(
      alignment: alignment,
      duration: const Duration(milliseconds: 10),
      curve: Curves.bounceOut,
      child: Image.asset(
        imagePath,
        width: size.width,
        height: size.height,
      ),
    );
  }

  Widget _buildBottomAnimationLogo(
    ({double height, double width}) flutterLogoSize,
    (double, double) androidLogoSize,
  ) {
    var isLandscape = Get.context!.isPhone ? Get.context!.isLandscape : false;

    return Align(
      alignment: Alignment(0, isLandscape ? 1 : 0.52),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.splashLogoFlutter,
            width: flutterLogoSize.width,
            height: flutterLogoSize.height,
          ),
          Image.asset(
            Images.splashLogoAndroid,
            width: androidLogoSize.$1,
            height: androidLogoSize.$2,
          )
        ],
      ),
    );
  }

}
