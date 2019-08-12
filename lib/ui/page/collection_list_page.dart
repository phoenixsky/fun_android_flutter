import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/service/wan_android_repository.dart';
import 'package:wan_android/ui/widget/article_list_Item.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/view_model/colletion_model.dart';
import 'package:wan_android/view_model/user_model.dart';

class CollectionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.block),
            tooltip: '测试cookie过期',
            onPressed: () async {
              showToast('登录cookie已过期');
              await WanAndroidRepository.logout();
            },
          )
        ],
      ),
      body: ProviderWidget<CollectionListModel>(
        model: CollectionListModel(userModel: Provider.of(context)),
        onModelReady: (model) {
          model.init();
        },
        builder: (context, model, child) {
          if (model.busy) {
            return PageStateLoading();
          }
          if (model.error) {
            return PageStateError(onPressed: model.init);
          }
          if (model.empty) {
            return PageStateEmpty(onPressed: model.init);
          }
          if (model.unAuthorized) {
            return PageStateUnAuthorized(onPressed: () async {
              await Navigator.of(context).pushNamed(RouteName.login);
              model.init();
            });
          }
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropHeader(),
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              child: ListView.builder(
                  itemCount: model.list.length,
                  itemBuilder: (context, index) {
                    Article item = model.list[index];
                    return ArticleItemWidget(item);
                  }));
        },
      ),
    );
  }
}
