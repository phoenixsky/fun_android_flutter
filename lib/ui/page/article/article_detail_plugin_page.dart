import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/ui/helper/favourite_helper.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/view_model/favourite_model.dart';
import 'package:fun_android/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article_detail_page.dart';

class ArticleDetailPluginPage extends StatefulWidget {
  final Article article;

  ArticleDetailPluginPage({this.article});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<ArticleDetailPluginPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  Completer<bool> _finishedCompleter = Completer();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      debugPrint('onStateChanged: ${state.type} ${state.url}');
      if (!_finishedCompleter.isCompleted &&
          state.type == WebViewState.finishLoad) {
        _finishedCompleter.complete(true);
      }
    });
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.article.link,
      withJavascript: true,
      displayZoomControls: true,
      withZoom: true,
      appBar: AppBar(
        title: WebViewTitle(
          title: widget.article.title,
          future: _finishedCompleter.future,
        ),
        actions: <Widget>[
          IconButton(
//            tooltip: '用浏览器打开',
            icon: Icon(Icons.language),
            onPressed: () {
              launch(widget.article.link, forceSafariVC: false);
            },
          ),
          IconButton(
//            tooltip: '分享',
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.article.link, subject: widget.article.title);
            },
          ),
        ],
      ),
      bottomNavigationBar: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(opacity: 0.5),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: flutterWebViewPlugin.goBack,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: flutterWebViewPlugin.goForward,
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: flutterWebViewPlugin.reload,
              ),
              ProviderWidget<FavouriteModel>(
                model: FavouriteModel(
                    globalFavouriteModel: Provider.of(context, listen: false)),
                builder: (context, model, child) => IconButton(
                  icon:
                      Provider.of<UserModel>(context, listen: false).hasUser &&
                                  widget.article.collect ??
                              true
                          ? Icon(Icons.favorite, color: Colors.redAccent[100])
                          : Icon(Icons.favorite_border),
                  onPressed: () async {
                    await addFavourites(context,
                        article: widget.article, model: model, playAnim: false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
