import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wan_android/config/resource_mananger.dart';
import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/view_model/colletion_model.dart';

import 'animated_provider.dart';
import 'article_tag.dart';
import 'dialog_helper.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final int index;
  final GestureTapCallback onTap;
  final bool top;

  ArticleItemWidget(this.article, {this.index, this.onTap, this.top: false})
      : super(key: ValueKey(article.id));

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Material(
      color:
          top ? Theme.of(context).accentColor.withAlpha(10) : backgroundColor,
      child: InkWell(
        onTap: onTap ??
            () {
              Navigator.of(context).pushNamed(RouteName.webView,
                  arguments: article);
            },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border: Border(
            bottom: Divider.createBorderSide(context, width: 0.7),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: ImageHelper.randomUrl(
                          key: article.author, width: 20, height: 20),
                      placeholder: (_, __) =>
                          ImageHelper.placeHolder(width: 20, height: 20),
                      errorWidget: (_, __, ___) =>
                          ImageHelper.error(width: 20, height: 20),
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      article.author,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  Text(article.niceDate,
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              if (article.envelopePic.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: ArticleTitleWidget(article),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ArticleTitleWidget(article),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            article.desc,
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: article.envelopePic,
                      height: 60,
                      width: 60,
                      placeholder: (_, __) =>
                          ImageHelper.placeHolder(width: 60, height: 60),
                      errorWidget: (_, __, ___) =>
                          ImageHelper.error(width: 60, height: 60),
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (top) ArticleTag('置顶'),
                  Text(
                    (article.superChapterName == null
                                ? ''
                                : article.superChapterName + ' · ') +
                            article.chapterName ??
                        '',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  ArticleCollectionWidget(article)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final Article article;

  ArticleTitleWidget(this.article);

  @override
  Widget build(BuildContext context) {
    return Html(
      padding: EdgeInsets.symmetric(vertical: 5),
      useRichText: false,
      data: article.title,
      defaultTextStyle: Theme.of(context).textTheme.subtitle,
    );
  }
}

class ArticleCollectionWidget extends StatelessWidget {
  final Article article;

  ArticleCollectionWidget(this.article);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CollectionModel>(
      model: CollectionModel(article),
      builder: (context, model, child) {
        return InkWell(
          onTap: () async {
            if (!model.busy) {
              await model.collect();
              if (model.unAuthorized) {
                DialogHelper.showLoginDialog(context);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ScaleAnimatedSwitcher(
              child: model.busy
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CupertinoActivityIndicator(
                        radius: 8,
                      ),
                    )
                  : Icon(
                      // 收藏列表返回的collect为空.article.collect
                      model.article.collect ?? true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.redAccent[100],
                    ),
            ),
          ),
        );
      },
    );
  }
}
