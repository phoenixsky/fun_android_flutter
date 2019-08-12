import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:wan_android/config/ui_adapter_config.dart';
import 'package:wan_android/config/storage_manager.dart';

import 'config/provider_manager.dart';
import 'config/router_config.dart';
import 'view_model/theme_model.dart';

//void main() => runApp(App());

void main() async {
  await StorageManager.init();
  Provider.debugCheckInvalidValueType = null;
  InnerWidgetsFlutterBinding.ensureInitialized()
    ..attachRootWidget(new App())
    ..scheduleWarmUpFrame();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
            providers: providers,
            child: Builder(builder: (context) {
              var themeModel = Provider.of<ThemeModel>(context);
              return RefreshConfiguration(
                hideFooterWhenNotFull: true,
                child: MaterialApp(
                  theme: themeModel.value,
                  darkTheme: themeModel.darkTheme,
                  onGenerateRoute: Router.generateRoute,
                  initialRoute: RouteName.splash,
                ),
              );
            })));
  }
}
