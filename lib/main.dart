import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'package:wan_android/config/ui_adapter_config.dart';

import 'config/net/http.dart';
import 'config/provider_manager.dart';
import 'config/router_config.dart';
import 'view_model/theme_model.dart';

//void main() => runApp(App());

void main() async {
  await Http().addCookie();
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
              var platformBrightnessOf =
                  MediaQuery.platformBrightnessOf(context);
              debugPrint('platformBrightnessOf--$platformBrightnessOf');
              return MaterialApp(
                theme: themeModel.value,
                darkTheme: themeModel.darkTheme,
                onGenerateRoute: Router.generateRoute,
                initialRoute: RouteName.splash,
              );
            })));
  }
}
