import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funflutter_wandroid/ui/router/app_pages.dart';

import 'package:get/get.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      // theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
    );
  }
}
