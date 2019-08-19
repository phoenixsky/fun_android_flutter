import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/flutter/search.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/provider/scroll_controller_model.dart';
import 'package:wan_android/ui/widget/animated_provider.dart';
import 'package:wan_android/ui/widget/banner_image.dart';
import 'package:wan_android/ui/widget/like_animation.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/ui/widget/article_list_Item.dart';
import 'package:wan_android/ui/widget/article_skeleton.dart';
import 'package:wan_android/view_model/colletion_model.dart';
import 'package:wan_android/view_model/home_model.dart';

import 'package:wan_android/ui/page/search/search_delegate.dart';

import 'package:wan_android/ui/page/tab/home_second_floor_page.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;

    /// iPhoneX 头部适配
    var top = MediaQuery.of(context).padding.top;
    var bannerHeight = size.width * 9 / 16 - top;

    return ProviderWidget2<HomeModel, TapToTopModel>(
      model1: HomeModel(),
      // 保留iOS点击状态栏回到顶部的功能
      model2: TapToTopModel(PrimaryScrollController.of(context),
          height: bannerHeight - kToolbarHeight),
      onModelReady: (homeModel, tapToTopModel) {
        homeModel.initData();
        tapToTopModel.init();
      },
      builder: (context, homeModel, tapToTopModel, child) {
        return Scaffold(
          body: MediaQuery.removePadding(
              context: context,
              removeTop: false,
              child: Builder(builder: (_) {
                if (homeModel.error) {
                  return PageStateError(onPressed: homeModel.initData);
                }
                return ProviderWidget<CollectionAnimationModel>(
                    model: CollectionAnimationModel(),
                    builder: (context, collectionAnimationModel, child) =>
                        Stack(
                          children: <Widget>[child, LikeAnimatedWidget()],
                        ),
                    child: RefreshConfiguration.copyAncestor(
                      context: context,
                      // 下拉触发二楼距离
                      twiceTriggerDistance: kHomeRefreshHeight - 15,
                      //最大下拉距离,android默认为0,这里为了触发二楼
                      maxOverScrollExtent: kHomeRefreshHeight,
                      child: SmartRefresher(
                          enableTwoLevel: true,
                          controller: homeModel.refreshController,
                          header: ClassicHeader(
                            textStyle: TextStyle(color: Colors.white),
                            outerBuilder: (child) =>
                                HomeSecondFloorOuter(child),
                            twoLevelView: Container(),
                          ),
                          onTwoLevel: () async {
                            await Navigator.of(context)
                                .pushNamed(RouteName.homeSecondFloor);
                            await Future.delayed(Duration(milliseconds: 300));
                            Provider.of<HomeModel>(context)
                                .refreshController
                                .twoLevelComplete();
                          },
                          onRefresh: homeModel.refresh,
                          onLoading: homeModel.loadMore,
                          enablePullUp: true,
                          child: CustomScrollView(
                            controller: tapToTopModel.scrollController,
                            slivers: <Widget>[
                              SliverToBoxAdapter(),
                              SliverAppBar(
                                actions: <Widget>[
                                  EmptyAnimatedSwitcher(
                                    display: tapToTopModel.showTopBtn,
                                    child: IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: () {
                                        showSearch(
                                            context: context,
                                            delegate: DefaultSearchDelegate());
                                      },
                                    ),
                                  ),
                                ],
                                flexibleSpace: FlexibleSpaceBar(
                                  background: BannerWidget(),
                                  centerTitle: true,
                                  title: GestureDetector(
                                    onDoubleTap: tapToTopModel.scrollToTop,
                                    child: EmptyAnimatedSwitcher(
                                      display: tapToTopModel.showTopBtn,
                                      child: Text('玩Android'),
                                    ),
                                  ),
                                ),
                                expandedHeight: bannerHeight,
                                pinned: true,
                              ),
                              SliverPadding(
                                padding: EdgeInsets.only(top: 5),
                              ),
                              HomeTopArticleList(),
                              HomeArticleList(),
                            ],
                          )),
                    ));
              })),
          floatingActionButton: ScaleAnimatedSwitcher(
            child: tapToTopModel.showTopBtn &&
                    homeModel.refreshController.headerStatus !=
                        RefreshStatus.twoLevelOpening
                ? FloatingActionButton(
                    key: ValueKey(Icons.vertical_align_top),
                    onPressed: () {
                      tapToTopModel.scrollToTop();
                    },
                    child: Icon(
                      Icons.vertical_align_top,
                    ),
                  )
                : FloatingActionButton(
                    heroTag: 'homeFab',
                    key: ValueKey(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: DefaultSearchDelegate());
                    },
                    child: Icon(
                      Icons.search,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Consumer<HomeModel>(builder: (_, homeModel, __) {
            if (homeModel.busy) {
              return CupertinoActivityIndicator();
            } else {
              var banners = homeModel?.banners ?? [];
              return Swiper(
                loop: true,
                autoplay: true,
                autoplayDelay: 5000,
                pagination: SwiperPagination(),
                itemCount: banners.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                      onTap: () {
                        var banner = banners[index];
                        Navigator.of(context).pushNamed(RouteName.articleDetail,
                            arguments: Article()
                              ..id = banner.id
                              ..title = banner.title
                              ..link = banner.url
                              ..collect = false);
                      },
                      child: BannerImage(banners[index].imagePath));
                },
              );
            }
          }),
        ));
  }
}

class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Article item = homeModel.topArticles[index];
          return ArticleItemWidget(
            item,
            index: index,
            top: true,
          );
        },
        childCount: homeModel.topArticles?.length ?? 0,
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    if (homeModel.busy) {
      // 固定高度可提升效率 此处所谓demo
      return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => SkeletonListItem(
                  index: index,
                ),
            childCount: 5),
        itemExtent: 120,
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Article item = homeModel.list[index];
          return ArticleItemWidget(
            item,
            index: index,
          );
        },
        childCount: homeModel.list?.length ?? 0,
      ),
    );
  }
}
