import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/ui/widget/article_list_Item.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/view_model/search_model.dart';

class SearchResults extends StatelessWidget {
  final String keyword;
  final  SearchHistoryModel searchHistoryModel;

  SearchResults({this.keyword, this.searchHistoryModel});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchResultModel>(
      model: SearchResultModel(keyword:keyword,searchHistoryModel:searchHistoryModel),
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
    );
  }
}
