import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/ui/helper/favourite_helper.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/utils/string_utils.dart';
import 'package:fun_android/utils/third_app_utils.dart';
import 'package:fun_android/view_model/favourite_model.dart';
import 'package:fun_android/view_model/theme_model.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  ArticleDetailPage({this.article});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<ArticleDetailPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WebViewTitle(
          title: widget.article.title,
          future: _finishedCompleter.future,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              launch(widget.article.link, forceSafariVC: false);
            },
          ),
          WebViewPopupMenu(
            _webViewController,
            widget.article,
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          // 初始化加载的url
          initialUrl: widget.article.link,
          // 加载js
          javascriptMode: JavascriptMode.unrestricted,

          navigationDelegate: (NavigationRequest request) {
            ///TODO isForMainFrame为false,页面不跳转.导致网页内很多链接点击没效果
            debugPrint('导航$request');
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
            _webViewController.currentUrl().then((url) {
              debugPrint('返回当前$url');
            });
          },
          onPageFinished: (String value) async {
            debugPrint('加载完成: $value');
            if (!_finishedCompleter.isCompleted)
              _finishedCompleter.complete(true);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _webViewController.goBack();
                }),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _webViewController.goForward();
                }),
          ],
        ),
      ),
      floatingActionButton: FutureBuilder<String>(
        future: ThirdAppUtils.canOpenApp(widget.article.link),
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

class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;

  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FutureBuilder<bool>(
          future: future,
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
          //移除html标签
          StringUtils.removeHtmlLabel(title),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        ))
      ],
    );
  }
}

class WebViewPopupMenu extends StatelessWidget {
  final WebViewController controller;
  final Article article;

  WebViewPopupMenu(this.controller, this.article);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavouriteModel>.value(
          value: FavouriteModel(article),
        )
      ],
      child: Builder(
        builder: (context) {
          var favouriteModel = Provider.of<FavouriteModel>(context);
          return PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child:
                    WebViewPopupMenuItem(Icons.refresh, S.of(context).refresh),
                value: 0,
              ),
              PopupMenuItem(
                child: (favouriteModel.article.collect ?? true)
                    ? WebViewPopupMenuItem(Icons.favorite, S.of(context).unLike,
                        color: Colors.redAccent[100])
                    : WebViewPopupMenuItem(
                        Icons.favorite_border, S.of(context).Like),
                value: 1,
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: WebViewPopupMenuItem(Icons.share, S.of(context).share),
                value: 2,
              ),
            ],
            onSelected: (value) async {
              switch (value) {
                case 0:
                  controller.reload();
                  break;
                case 1:
                  addFavourites(context, favouriteModel, 'detail');
                  break;
                case 2:
                  Share.share(article.link, subject: article.title);
                  break;
                case 3:
                  Provider.of<ThemeModel>(context).switchRandomTheme();
                  break;
              }
            },
          );
        },
      ),
    );
  }
}

class WebViewPopupMenuItem<T> extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String text;

  WebViewPopupMenuItem(this.iconData, this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 20,
          color: color ?? Theme.of(context).textTheme.body1.color,
        ),
        SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    );
  }
}
