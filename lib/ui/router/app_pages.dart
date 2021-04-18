import 'package:funflutter_wandroid/ui/page/splash/splash_view.dart';
import 'package:get/get.dart';
import 'package:funflutter_wandroid/ui/page/home/home_view.dart';
import 'package:funflutter_wandroid/ui/page/main_tab/main_tab_view.dart';

abstract class AppRoutes {
  static const SPLASH = "/splash";
  static const HOME = "/home";
  static const MAIN_TAB = "/main_tab";
}

abstract class AppPages {
  static const INITIAL = AppRoutes.SPLASH;

  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashPage()),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),
    GetPage(name: AppRoutes.MAIN_TAB, page: () => MainTabPage()),
  ];
}
