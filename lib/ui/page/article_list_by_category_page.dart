import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/model/tree.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/ui/widget/article_list_Item.dart';
import 'package:wan_android/view_model/tree_model.dart';

class TreeListTabPage extends StatelessWidget {
  final Tree tree;
  final int index;

  TreeListTabPage(this.tree, this.index);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tree.children.length,
      initialIndex: index,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(tree.name),
            bottom: TabBar(
                isScrollable: true,
                tabs: List.generate(
                    tree.children.length,
                    (index) => Tab(
                          text: tree.children[index].name,
                        ))),
          ),
          body: TabBarView(
            children: List.generate(tree.children.length,
                (index) => TreeListWidget(tree.children[index])),
          )),
    );
  }
}

class TreeListWidget extends StatefulWidget {
  final Tree tree;

  TreeListWidget(this.tree);

  @override
  _TreeListWidgetState createState() => _TreeListWidgetState();
}

class _TreeListWidgetState extends State<TreeListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    debugPrint('_TreeListWidgetState--initState--' + widget.tree.name);

    super.initState();
  }

  @override
  void dispose() {
    debugPrint('_TreeListWidgetState--dispose--' + widget.tree.name);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TreeListModel>(
      model: TreeListModel(widget.tree.id),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.busy) {
          return PageStateListSkeleton();
        }
        if (model.error) {
          return PageStateError(onPressed: model.initData);
        }
        if (model.empty) {
          return PageStateEmpty(onPressed: model.initData);
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
