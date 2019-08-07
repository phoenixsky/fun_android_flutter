import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/model/tree.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/view_model/theme_model.dart';
import 'package:wan_android/view_model/tree_model.dart';

class TreeCategoryPage extends StatefulWidget {
  @override
  _TreeCategoryPageState createState() => _TreeCategoryPageState();
}

class _TreeCategoryPageState extends State<TreeCategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<TreeCategoryModel>(
      model: TreeCategoryModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, treeListModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: InkWell(
                onTap: () {
                  Provider.of<ThemeModel>(context).switchRandomTheme();
                },
                child: Text('体系')),
          ),
          body: Builder(builder: (_) {
            if (treeListModel.busy) {
              return Center(child: CircularProgressIndicator());
            }
            if (treeListModel.error) {
              return PageStateError(onPressed: treeListModel.init);
            }
            return Scrollbar(
              child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: treeListModel.list.length,
                  itemBuilder: (context, index) {
                    Tree item = treeListModel.list[index];
                    return TreeCategoryWidget(item);
                  }),
            );
          }),
        );
      },
    );
  }
}

class TreeCategoryWidget extends StatelessWidget {
  final Tree tree;

  TreeCategoryWidget(this.tree);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tree.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Wrap(
              spacing: 10,
              children: List.generate(
                  tree.children.length,
                  (index) => ActionChip(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteName.treeList,
                              arguments: [tree, index]);
                        },
                        label: Text(
                          tree.children[index].name,
                          maxLines: 1,
                        ),
                      )))
        ],
      ),
    );
  }
}
