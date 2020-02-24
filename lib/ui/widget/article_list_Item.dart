import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fun_android/generated/l10n.dart';
import 'package:fun_android/ui/helper/favourite_helper.dart';
import 'package:fun_android/config/router_manger.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/view_model/favourite_model.dart';
import 'package:fun_android/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import 'image.dart';
import 'animated_provider.dart';
import 'article_tag.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final int index;
  final GestureTapCallback onTap;

  /// 首页置顶
  final bool top;

  /// 隐藏收藏按钮
  final bool hideFavourite;

  ArticleItemWidget(this.article,
      {this.index, this.onTap, this.top: false, this.hideFavourite: false})
      : super(key: ValueKey(article.id));

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    /// 用于Hero动画的标记
    UniqueKey uniqueKey = UniqueKey();
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
                        child: WrapperImage(
                          imageType: ImageType.random,
                          url: article.author,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          isNotBlank(article.author) ? article.author : article.shareUser ?? '',
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
                                height: 2,
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
                        WrapperImage(
                          url: article.envelopePic,
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  Row(
                    children: <Widget>[
                      if (top) ArticleTag(S.of(context).article_tag_top),
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
          child: hideFavourite
              ? SizedBox.shrink()
              : Consumer<GlobalFavouriteStateModel>(
                  builder: (context, model, child) {
                    //利用child局部刷新
                    if (model[article.id] == null) {
                      return child;
                    }
                    return ArticleFavouriteWidget(
                        article..collect = model[article.id],
                        uniqueKey);
                  },
                  child: ArticleFavouriteWidget(article, uniqueKey),
                ),
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

/// 收藏按钮
class ArticleFavouriteWidget extends StatelessWidget {
  final Article article;
  final UniqueKey uniqueKey;

  ArticleFavouriteWidget(this.article, this.uniqueKey);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavouriteModel>(
      model: FavouriteModel(
          globalFavouriteModel: Provider.of(context, listen: false)),
      builder: (_, favouriteModel, __) => GestureDetector(
          behavior: HitTestBehavior.opaque, //否则padding的区域点击无效
          onTap: () async {
            if (!favouriteModel.isBusy) {
              addFavourites(context,
                  article: article, model: favouriteModel, tag: uniqueKey);
            }
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Hero(
                tag: uniqueKey,
                child: ScaleAnimatedSwitcher(
                    child: favouriteModel.isBusy
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CupertinoActivityIndicator(radius: 5))
                        : Consumer<UserModel>(
                      builder: (context,userModel,child)=>Icon(
                          userModel.hasUser && article.collect
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent[100]),
                    )),
              ))),
    );
  }
}
