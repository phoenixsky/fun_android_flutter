import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tab_main_logic.dart';

class TabMainPage extends StatelessWidget {
  TabMainPage({Key? key}) : super(key: key);

  final logic = Get.put(TabMainLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FunFlutter 2.0"),
        centerTitle: true,
        leadingWidth: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("TabMain"),
      ),
    );
  }
}
