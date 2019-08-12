import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/config/resource_mananger.dart';
import 'package:wan_android/utils/platform_utils.dart';
import 'package:wan_android/utils/third_app_utils.dart';
import 'package:wan_android/view_model/theme_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oktoast/oktoast.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({this.url, this.title});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  WebViewController _controller;

  Completer<bool> _finishedCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            FutureBuilder<bool>(
              future: _finishedCompleter.future,
              initialData: false,
              builder: (context, snapshot) {
                return Offstage(
                  offstage: snapshot.data,
                  child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: CupertinoActivityIndicator()),
                );
              },
            ),
            Expanded(
                child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ))
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              launch(widget.url, forceSafariVC: false);
            },
          ),
          WebViewPopupMenu(_controller)
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            WebView(
              // 初始化加载的url
              initialUrl: widget.url,
              // 加载js
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                debugPrint('准备加载: ${request.url}');
                //对于需要拦截的操作 做判断 ios需要转为https.
                if (Platform.isIOS &&
                    request.url.startsWith("http://www.wanandroid.com")) {
                  //需要转https
                  var url = request.url.replaceFirst("http", 'https');
                  _controller.loadUrl(url);
                  return NavigationDecision.prevent;
                }
                //不需要拦截的操作
                debugPrint('没有拦截: ${request.url}');
//                _controller.loadUrl(request.url);
                return NavigationDecision.navigate;
              },
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
                _controller.currentUrl().then((url) {
                  debugPrint('返回当前$url');
                });
              },
              onPageFinished: (String value) {
                debugPrint('加载完成: $value');
                _finishedCompleter.complete(true);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FutureBuilder<String>(
        future: ThirdAppUtils.canOpenApp(widget.url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton(
              onPressed: () {
                ThirdAppUtils.openAppByUrl(snapshot.data);
              },
              child: Icon(Icons.open_in_new),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class WebViewPopupMenu extends StatelessWidget {
  final WebViewController _controller;

  WebViewPopupMenu(this._controller);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.refresh, '刷新'),
          value: 0,
        ),
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.favorite_border, '收藏'),
          value: 1,
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          child: WebViewPopupMenuItem(IconFonts.train, '火车'),
          value: 2,
          enabled: false,
        ),
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.color_lens, '切换主题'),
          value: 3,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 0:
            _controller.reload();
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            Provider.of<ThemeModel>(context).switchRandomTheme();
            break;
        }
      },
    );
  }
}

class WebViewPopupMenuItem<T> extends StatelessWidget {
  final IconData iconData;
  final String text;

  WebViewPopupMenuItem(this.iconData, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(iconData, size: 20),
        SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    );
  }
}
