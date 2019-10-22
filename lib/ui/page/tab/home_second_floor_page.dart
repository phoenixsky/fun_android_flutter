import 'package:flutter/material.dart';
import 'package:fun_android/config/resource_mananger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_page.dart';

class HomeSecondFloorOuter extends StatelessWidget {
  final Widget child;

  HomeSecondFloorOuter(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHomeRefreshHeight + MediaQuery.of(context).padding.top + 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              ImageHelper.wrapAssets('home_second_floor_builder.png')),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('跌跌撞撞中,依旧热爱这个世界.',
                style: Theme.of(context).textTheme.overline.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
          ),
          Align(alignment: Alignment(0, 0.85), child: child),
        ],
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}

class MyBlogPage extends StatefulWidget {
  @override
  _MyBlogPageState createState() => _MyBlogPageState();
}

class _MyBlogPageState extends State<MyBlogPage> {
  ValueNotifier<bool> notifier = ValueNotifier(false);

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'homeFab',
          child: Icon(Icons.arrow_downward),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).padding.top,
              bottom: 0,
              left: 0,
              right: 0,
              child: WebView(
                // 初始化加载的url
                initialUrl: 'http://blog.phoenixsky.cn',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {},
                onPageFinished: (String value) {
                  print('onPageFinished');
                  notifier.value = true;
                },
              ),
            ),
            Container(),
            ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, value, child) => value
                    ? SizedBox.shrink()
                    : Center(
                        child: CircularProgressIndicator(),
                      ))
          ],
        ));
  }
}
