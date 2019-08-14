import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/flutter/dropdown.dart';
import 'package:wan_android/model/tree.dart';

import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/ui/widget/page_state_switch.dart';
import 'package:wan_android/view_model/project_model.dart';

import '../article_list_by_category_page.dart';

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
        model.initData();
      },
      builder: (context, projectCategoryModel, child) {
        if (projectCategoryModel.busy) {
          return Center(child: CircularProgressIndicator());
        }
        if (projectCategoryModel.error) {
          return PageStateError(onPressed: projectCategoryModel.initData);
        }
        List<Tree> treeList = projectCategoryModel.list;
        var primaryColor = Theme.of(context).primaryColor;
        return DefaultTabController(
          length: projectCategoryModel.list.length,
          initialIndex: 0,
          child: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Stack(
                    children: [
                      CategoryDropdownWidget(treeList: treeList),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        color: primaryColor.withOpacity(1),
                        child: TabBar(
                            isScrollable: true,
                            tabs: List.generate(
                                treeList.length,
                                (index) => Tab(
                                      text: treeList[index].name,
                                    ))),
                      )
                    ],
                  ),
                ),
                body: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    TabBarView(
                      children: List.generate(treeList.length,
                          (index) => TreeListWidget(treeList[index])),
                    ),
                    Positioned(
                      child: Text('123'),
                      right: 50,
                      top: -50,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CategoryDropdownWidget extends StatelessWidget {
  final List<Tree> treeList;

  CategoryDropdownWidget({this.treeList});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            elevation: 0,
            value: DefaultTabController.of(context).index,
            style: Theme.of(context).primaryTextTheme.subhead,
            items: List.generate(
                treeList.length,
                (index) => DropdownMenuItem(
                      value: index,
                      child: Text(
                        treeList[index].name,
                      ),
                    )),
            onChanged: (value) {
              DefaultTabController.of(context).animateTo(value);
            },
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        ),
      ),
      alignment: Alignment(1.1, -1),
    );
  }
}
