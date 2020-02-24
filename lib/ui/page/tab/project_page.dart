import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fun_android/provider/view_state_list_model.dart';
import 'package:fun_android/utils/status_bar_utils.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/flutter/dropdown.dart';
import 'package:fun_android/model/tree.dart';
import 'package:fun_android/provider/provider_widget.dart';

import 'package:fun_android/provider/view_state_widget.dart';
import 'package:fun_android/view_model/project_model.dart';

import '../article/article_list_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> valueNotifier;
  TabController tabController;

  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ProviderWidget<ProjectCategoryModel>(
          model: ProjectCategoryModel(),
          onModelReady: (model) {
            model.initData();
          },
          builder: (context, model, child) {
            if (model.isBusy) {
              return ViewStateBusyWidget();
            }
            if (model.isError) {
              return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
            }

            List<Tree> treeList = model.list;
            var primaryColor = Theme.of(context).primaryColor;
            return ValueListenableProvider<int>.value(
              value: valueNotifier,
              child: DefaultTabController(
                length: model.list.length,
                initialIndex: valueNotifier.value,
                child: Builder(
                  builder: (context) {
                    if (tabController == null) {
                      tabController = DefaultTabController.of(context);
                      tabController.addListener(() {
                        valueNotifier.value = tabController.index;
                      });
                    }
                    return Scaffold(
                      appBar: AppBar(
                        title: Stack(
                          children: [
                            CategoryDropdownWidget(
                                Provider.of<ProjectCategoryModel>(context)),
                            Container(
                              margin: const EdgeInsets.only(right: 25),
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
                      body: TabBarView(
                        children: List.generate(treeList.length,
                            (index) => ArticleListPage(treeList[index].id)),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}

class CategoryDropdownWidget extends StatelessWidget {
  final ViewStateListModel model;

  CategoryDropdownWidget(this.model);

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<int>(context);
    return Align(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          elevation: 0,
          value: currentIndex,
          style: Theme.of(context).primaryTextTheme.subhead,
          items: List.generate(model.list.length, (index) {
            var theme = Theme.of(context);
            var subhead = theme.primaryTextTheme.subhead;
            return DropdownMenuItem(
              value: index,
              child: Text(
                model.list[index].name,
                style: currentIndex == index
                    ? subhead.apply(
                        fontSizeFactor: 1.15,
                        color: theme.brightness == Brightness.light
                            ? Colors.white
                            : theme.accentColor)
                    : subhead.apply(color: subhead.color.withAlpha(200)),
              ),
            );
          }),
          onChanged: (value) {
            DefaultTabController.of(context).animateTo(value);
          },
          isExpanded: true,
          icon: Container(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        )),
      ),
      alignment: Alignment(1.1, -1),
    );
  }
}
