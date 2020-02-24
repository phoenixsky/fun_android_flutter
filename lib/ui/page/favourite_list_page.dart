import 'package:flutter/material.dart'
    hide SliverAnimatedListState, SliverAnimatedList;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fun_android/generated/l10n.dart';
import 'package:fun_android/ui/helper/refresh_helper.dart';
import 'package:fun_android/ui/widget/article_skeleton.dart';
import 'package:fun_android/ui/widget/skeleton.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fun_android/config/router_manger.dart';
import 'package:fun_android/flutter/refresh_animatedlist.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/ui/widget/article_list_Item.dart';
import 'package:fun_android/provider/view_state_widget.dart';
import 'package:fun_android/view_model/favourite_model.dart';
import 'package:fun_android/view_model/login_model.dart';

/// 必须为StatefulWidget,才能根据[GlobalKey]取出[currentState].
/// 否则从详情页返回后,无法移除没有收藏的item
class FavouriteListPage extends StatefulWidget {
  @override
  _FavouriteListPageState createState() => _FavouriteListPageState();
}

class _FavouriteListPageState extends State<FavouriteListPage> {
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myFavourites),
      ),
      body: ProviderWidget<FavouriteListModel>(
        model: FavouriteListModel(loginModel: LoginModel(Provider.of(context))),
        onModelReady: (model) async {
          await model.initData();
        },
        builder: (context, FavouriteListModel model, child) {
          if (model.isBusy) {
            return SkeletonList(
              builder: (context, index) => ArticleSkeletonItem(),
            );
          } else if (model.isEmpty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          } else if (model.isError) {
            if (model.viewStateError.isUnauthorized) {
              return ViewStateUnAuthWidget(onPressed: () async {
                var success =
                    await Navigator.of(context).pushNamed(RouteName.login);
                // 登录成功,获取数据,刷新页面
                if (success ?? false) {
                  model.initData();
                }
              });
            } else if (model.list.isEmpty) {
              // 只有在页面上没有数据的时候才显示错误widget
              return ViewStateErrorWidget(
                  error: model.viewStateError, onPressed: model.initData);
            }
          }
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropHeader(),
              footer: RefresherFooter(),
              onRefresh: () async {
                await model.refresh();
                listKey.currentState.refresh(model.list.length);
              },
              onLoading: () async {
                await model.loadMore();
                listKey.currentState.refresh(model.list.length);
              },
              enablePullUp: true,
              child: CustomScrollView(slivers: <Widget>[
                SliverAnimatedList(
                    key: listKey,
                    initialItemCount: model.list.length,
                    itemBuilder: (context, index, animation) {
                      Article item = model.list[index];
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: S.of(context).collectionRemove,
                            color: Colors.redAccent,
                            icon: Icons.delete,
                            onTap: () {
                              FavouriteModel(
                                      globalFavouriteModel:
                                          Provider.of(context, listen: false))
                                  .collect(item);
                              removeItem(model.list, index);
                            },
                          )
                        ],
                        child: SizeTransition(
                            axis: Axis.vertical,
                            sizeFactor: animation,
                            child: ArticleItemWidget(
                              item,
                              hideFavourite: true,
                              onTap: () async {
                                await Navigator.of(context).pushNamed(
                                    RouteName.articleDetail,
                                    arguments: item);
                                if (!(item?.collect ?? true)) {
                                  removeItem(model.list, index);
                                }
                              },
                            )),
                      );
                    })
              ]));
        },
      ),
    );
  }

  /// 移除取消收藏的item
  removeItem(List list, int index) {
    var removeItem = list.removeAt(index);
    listKey.currentState.removeItem(
        index,
        (context, animation) => SizeTransition(
            axis: Axis.vertical,
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: ArticleItemWidget(
              removeItem,
              hideFavourite: true,
            )));
  }
}
