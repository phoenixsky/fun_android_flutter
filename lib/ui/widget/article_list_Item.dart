import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/config/resource_mananger.dart';
import 'package:fun_android/config/router_config.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/view_model/colletion_model.dart';

import 'animated_provider.dart';
import 'article_tag.dart';
import 'dialog_helper.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final int index;
  final GestureTapCallback onTap;

  /// 首页置顶
  final bool top;

  ArticleItemWidget(this.article, {this.index, this.onTap, this.top: false})
      : super(key: ValueKey(article.id));

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      children: <Widget>[
        Material(
          color: top
              ? Theme.of(context).accentColor.withAlpha(10)
              : backgroundColor,
          child: InkWell(
            onTap: onTap ??
                () {
                  Navigator.of(context)
                      .pushNamed(RouteName.articleDetail, arguments: article);
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
                      child: ArticleTitleWidget(article.title),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ArticleTitleWidget(article.title),
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
                        SizedBox(
                          width: 5,
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
                    children: <Widget>[
                      if (top) ArticleTag('置顶'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (article.superChapterName != null
                                  ? article.superChapterName + ' · '
                                  : '') +
                              (article.chapterName ?? ''),
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: article.collect == null
              ? SizedBox.shrink()
              : ArticleCollectionWidget(article),
        )
      ],
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  ArticleTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Html(
      padding: EdgeInsets.symmetric(vertical: 5),
      useRichText: false,
      data: title,
      defaultTextStyle: Theme.of(context).textTheme.subtitle,
    );
  }
}

class ArticleCollectionWidget extends StatelessWidget {
  final Article article;

  ArticleCollectionWidget(this.article);

  @override
  Widget build(BuildContext context) {
    var animationModel;
    try {
      animationModel = Provider.of<CollectionAnimationModel>(context);
    } catch (e) {}
    return ProviderWidget<CollectionModel>(
      model: CollectionModel(article, animationModel: animationModel),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () async {
            if (!model.busy) {
              toCollect(context, model);
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                      model.article.collect
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.redAccent[100],
//                      color: Color(0xffF44062),
                    ),
            ),
          ),
        );
      },
    );
  }

  /// 由于存在递归操作,所以抽取为方法,而且多出调用
  ///
  /// 多个页面使用该方法,目前这种方式并不优雅,抽取位置有待商榷
  static toCollect(context, CollectionModel model) async {
    await model.collect();
    if (model.unAuthorized) {
      //未登录
      if (await DialogHelper.showLoginDialog(context)) {
        var success = await Navigator.pushNamed(context, RouteName.login);
        if (success ?? false) toCollect(context, model);
      }
    } else if (model.error) {
      //失败
      showToast(S.of(context).loadFailed);
    }
  }
}
