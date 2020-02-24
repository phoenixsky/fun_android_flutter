import 'package:flutter/material.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/provider/view_state_widget.dart';
import 'package:fun_android/ui/helper/refresh_helper.dart';
import 'package:fun_android/ui/widget/skeleton.dart';
import 'package:fun_android/view_model/coin_model.dart';
import 'package:fun_android/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///积分排行榜
class CoinRankingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    String selfName = userModel.user.username.replaceRange(1, 3, '**');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('积分排行榜'),
      ),
      body: ProviderWidget<CoinRankingListModel>(
        model: CoinRankingListModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return SkeletonList(
              length: 11,
              builder: (context, index) => CoinRankingListItemSkeleton(),
            );
          } else if (model.isError && model.list.isEmpty) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          } else if (model.isEmpty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          }
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropHeader(),
              footer: RefresherFooter(),
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              child: ListView.separated(
                  itemCount: model.list.length,
                  separatorBuilder: (context, index) => Divider(
                        indent: 10,
                        endIndent: 10,
                        height: 1,
                      ),
                  itemBuilder: (context, index) {
//                    {"coinCount": 448,"username": "S**24n"},
                    Map item = model.list[index];
                    String userName = item['username'];
                    String coinCount = item['coinCount'].toString();
                    return ListTile(
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      onTap: () {},
                      leading: Text('${index + 1}'),
                      title: Text(userName,
                          style: TextStyle(
                            fontSize: 16,
                              color: selfName == userName
                                  ? Colors.amberAccent
                                  : null)),
                      trailing: Text(
                        coinCount,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    );
                  }));
        },
      ),
    );
  }
}

class CoinRankingListItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BottomBorderDecoration(),
      child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          title: Row(children: <Widget>[
            SkeletonBox(width: 20, height: 10),
            SizedBox(width: 20),
            SkeletonBox(width: 250, height: 10)
          ]),
          trailing: SkeletonBox(width: 20, height: 10)),
    );
  }
}
