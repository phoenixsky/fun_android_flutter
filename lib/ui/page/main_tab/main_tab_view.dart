import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:funflutter_wandroid/ui/page/home/home_view.dart';
import 'package:get/get.dart';

import 'main_tab_logic.dart';

/// 底部tabBar
final _tabBars = {
  "tabHome".tr: Icons.home,
  "tabProject".tr: Icons.format_list_bulleted,
  "tabStructure".tr: Icons.group_work,
  "tabWechat".tr: Icons.call_split,
  "tabUser".tr: Icons.insert_emoticon,
};

List<Widget> _pages = <Widget>[
  HomePage(),
  HomePage(),
  HomePage(),
  HomePage(),
  HomePage(),
  // ProjectPage(),
  // WechatAccountPage(),
  // StructurePage(),
  // UserPage()
];

class MainTabPage extends HookWidget {
  final MainTabLogic logic = Get.put(MainTabLogic());

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    // 默认tab索引是0
    final tabIndex = useState(0);
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (ctx, index) => _pages[index],
        itemCount: _pages.length,
        controller: pageController,
        onPageChanged: (index) {
          tabIndex.value = index;
        },
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomTabBar(
        pageController: pageController,
        currentIndex: tabIndex.value,
      ),
    );
  }
}

/// 底部tabBar按钮
class BottomTabBar extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;

  const BottomTabBar(
      {Key? key, required this.pageController, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        pageController.jumpToPage(index);
      },
      // 修正选中的索引
      currentIndex: currentIndex,
      items: _tabBars.entries
          .map(
              (e) => BottomNavigationBarItem(label: e.key, icon: Icon(e.value)))
          .toList(),
    );
  }
}
