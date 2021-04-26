import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funflutter_wandroid/ui/router/app_pages.dart';

import 'dart:ui' as ui;

import 'package:get/get.dart';

import 'constants/app_translations.dart';

void main() {
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => botToastBuilder(context, child),
        // theme: appThemeData,
        initialRoute: AppPages.INITIAL,
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        navigatorObservers: [BotToastNavigatorObserver()],
        // locale
        translations: AppTranslations(),
        // 系统语言
        locale: ui.window.locale,
        // 添加一个回调语言选项，以备上面指定的语言翻译不存在
        fallbackLocale: Locale('en', 'US'));
  }
}
