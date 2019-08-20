import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/config/resource_mananger.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/ui/widget/dialog_helper.dart';
import 'package:fun_android/ui/widget/like_animation.dart';
import 'package:fun_android/utils/string_utils.dart';
import 'package:fun_android/utils/third_app_utils.dart';
import 'package:fun_android/view_model/colletion_model.dart';
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
  WebViewController _controller;

  Completer<bool> _finishedCompleter = Completer();

  CollectionAnimationModel _animationModel = CollectionAnimationModel();

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
            _controller,
            widget.article,
            animationModel: _animationModel,
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: ProviderWidget<CollectionAnimationModel>(
            model: _animationModel,
            builder: (context, model, child) => Stack(
                  children: <Widget>[
                    child,
                    LikeAnimatedWidget(),
                  ],
                ),
            child: WebView(
              // 初始化加载的url
              initialUrl: widget.article.link,
              // 加载js
              javascriptMode: JavascriptMode.unrestricted,
//              navigationDelegate: (NavigationRequest request) {
//                return NavigationDecision.navigate;
//              },
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
            )),
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
  final CollectionAnimationModel animationModel;

  WebViewPopupMenu(this.controller, this.article, {this.animationModel});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CollectionModel>.value(
            value: CollectionModel(article, animationModel: animationModel)),
      ],
      child: Builder(
        builder: (context) {
          var collectionModel = Provider.of<CollectionModel>(context);
          return PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: WebViewPopupMenuItem(Icons.refresh, '刷新'),
                value: 0,
              ),
              PopupMenuItem(
                child: (collectionModel.article.collect ?? true)
                    ? WebViewPopupMenuItem(Icons.favorite, '取消收藏',
                        color: Colors.redAccent[100])
                    : WebViewPopupMenuItem(Icons.favorite_border, '收藏'),
                value: 1,
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: WebViewPopupMenuItem(Icons.share, '分享'),
                value: 2,
              ),
//              PopupMenuItem(
//                child: WebViewPopupMenuItem(Icons.color_lens, '切换主题'),
//                value: 3,
//              ),
            ],
            onSelected: (value) async {
              switch (value) {
                case 0:
                  controller.reload();
                  break;
                case 1:
                  await collectionModel.collect();
                  if (collectionModel.unAuthorized) {
                    DialogHelper.showLoginDialog(context);
                  }
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
          color: color,
        ),
        SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    );
  }
}
