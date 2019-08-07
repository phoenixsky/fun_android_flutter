import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/view_model/project_model.dart';

import '../tree_list_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<ProjectCategoryModel>(
      model: ProjectCategoryModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, projectCategoryModel, child) {
        if (projectCategoryModel.busy) {
          return Center(child: CircularProgressIndicator());
        }
        if (projectCategoryModel.error) {
          return PageStateError(onPressed: projectCategoryModel.init);
        }
        var treeList = projectCategoryModel.list;
        return DefaultTabController(
          length: projectCategoryModel.list.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: TabBar(
                  isScrollable: true,
                  tabs: List.generate(
                      treeList.length,
                      (index) => Tab(
                            text: treeList[index].name,
                          ))),
            ),
            body: TabBarView(
              children: List.generate(
                  treeList.length, (index) => TreeListWidget(treeList[index])),
            ),
          ),
        );
      },
    );
  }
}
