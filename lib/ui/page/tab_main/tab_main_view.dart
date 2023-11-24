import 'package:flutter/material.dart';
import 'package:funflutter_wanandroid/ui/page/tabs/project_list/project_list_view.dart';
import 'package:funflutter_wanandroid/ui/page/tabs/user_setting/user_setting_view.dart';
import 'package:get/get.dart';

import '../tabs/home/home_view.dart';
import 'tab_main_logic.dart';

class TabMainPage extends StatelessWidget {
  TabMainPage({Key? key}) : super(key: key);

  final logic = Get.put(TabMainLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text("FunFlutter 2.0"),
        //   centerTitle: true,
        //   leadingWidth: 0,
        // ),
        body: PageView(
          onPageChanged: (index) => logic.currentIndex.value = index,
          children:  [
            HomePage(),
            ProjectListPage(),
            ProjectListPage(),
            ProjectListPage(),
            UserSettingPage()
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: logic.currentIndex.value,
        onTap: (index) {
          logic.currentIndex.value = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: "项目",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "公众号",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            label: "体系",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            label: "我的",
          ),
        ],
      );
  }
}
