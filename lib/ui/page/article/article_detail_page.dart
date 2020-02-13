import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_android/generated/l10n.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/ui/helper/favourite_helper.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/ui/widget/app_bar.dart';
import 'package:fun_android/utils/string_utils.dart';
import 'package:fun_android/utils/third_app_utils.dart';
import 'package:fun_android/view_model/favourite_model.dart';
import 'package:fun_android/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  ArticleDetailPage({this.article});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();

  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);

  Future canOpenAppFuture;

  @override
  void initState() {
    canOpenAppFuture = ThirdAppUtils.canOpenApp(widget.article.link);
    super.initState();
  }

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
            tooltip: S.of(context).openBrowser,
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
            if (!request.url.startsWith('http')) {
              ThirdAppUtils.openAppByUrl(request.url);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
            _webViewController.currentUrl().then((url) {
              debugPrint('返回当前$url');
            });
          },
          onPageFinished: (String value) async {
            debugPrint('加载完成: $value');
            if (!_finishedCompleter.isCompleted) {
              _finishedCompleter.complete(true);
            }
            refreshNavigator();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(opacity: 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: canGoBack,
                builder: (context, value, child) => IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: !value
                        ? null
                        : () {
                            _webViewController.goBack();
                            refreshNavigator();
                          }),
              ),
              ValueListenableBuilder(
                valueListenable: canGoForward,
                builder: (context, value, child) => IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: !value
                        ? null
                        : () {
                            _webViewController.goForward();
                            refreshNavigator();
                          }),
              ),
              IconButton(
                tooltip: S.of(context).refresh,
                icon: const Icon(Icons.autorenew),
                onPressed: () {
                  _webViewController.reload();
                },
              ),
              ProviderWidget<FavouriteModel>(
                model: FavouriteModel(
                    globalFavouriteModel: Provider.of(context, listen: false)),
                builder: (context, model, child) {
                  var tag = 'detail';
                  var userModel =
                      Provider.of<UserModel>(context, listen: false);
                  return IconButton(
                    tooltip: S.of(context).favourites,
                    icon: Hero(
                      tag: tag,
                      child: Icon(
                          userModel.hasUser && (widget.article.collect ?? true)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent[100]),
                    ),
                    onPressed: () async {
                      await addFavourites(context,
                          article: widget.article, model: model, tag: tag);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FutureBuilder<String>(
        future: canOpenAppFuture,
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

  /// 刷新导航按钮
  ///
  /// 目前主要用来控制 '前进','后退'按钮是否可以点击
  /// 但是目前该方法没有合适的调用时机.
  /// 在[onPageFinished]中,会遗漏正在加载中的状态
  /// 在[navigationDelegate]中,会存在页面还没有加载就已经判断过了.
  void refreshNavigator() {
    /// 是否可以后退
    _webViewController.canGoBack().then((value) {
      debugPrint('canGoBack--->$value');
      return canGoBack.value = value;
    });

    /// 是否可以前进
    _webViewController.canGoForward().then((value) {
      debugPrint('canGoForward--->$value');
      return canGoForward.value = value;
    });
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
          builder: (context, snapshot) => snapshot.data
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 5), child: AppBarIndicator()),
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
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: WebViewPopupMenuItem(Icons.share, S.of(context).share),
          value: 2,
        ),
//        PopupMenuDivider(),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            Share.share(article.title + ' ' + article.link);
            break;
        }
      },
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
