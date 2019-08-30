import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fun_android/config/ui_adapter_config.dart';
import 'package:fun_android/config/storage_manager.dart';
import 'package:fun_android/ui/page/splash.dart';

import 'config/provider_manager.dart';
import 'config/router_config.dart';
import 'generated/i18n.dart';
import 'view_model/locale_model.dart';
import 'view_model/theme_model.dart';

main() async {
  Provider.debugCheckInvalidValueType = null;

  /// 全局屏幕适配方案
  InnerWidgetsFlutterBinding.ensureInitialized()
    ..attachRootWidget(App(future: StorageManager.init()))
    ..scheduleWarmUpFrame();
}

class App extends StatelessWidget {
  /// 在App运行之前,需要初始化的异步操作
  /// 如果存在多个,可以使用[Future.wait(futures)]来合并future后传入
  final Future future;

  const App({this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          /// 在异步操作时,显示的页面
          if (snapshot.connectionState != ConnectionState.done) {
            return SplashImage();
          }
          return OKToast(
              child: MultiProvider(
                  providers: providers,
                  child: Consumer2<ThemeModel, LocaleModel>(
                      builder: (context, themeModel, localeModel, child) {
                    return RefreshConfiguration(
                      hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                      child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: themeModel.themeData,
                        darkTheme: themeModel.darkTheme,
                        locale: localeModel.locale,
                        localizationsDelegates: const [
                          S.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        onGenerateRoute: Router.generateRoute,
                        initialRoute: RouteName.splash,
                      ),
                    );
                  })));
        });
  }
}
