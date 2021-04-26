import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: logic.fetchBanners,
              child: Text("testNetErrorFutureOnError"),
            ),
            ElevatedButton(
              onPressed: logic.fetchBanners,
              child: Text("testNetErrorFutureCacheError"),
            ),
            ElevatedButton(
              onPressed: logic.fetchBanners,
              child: Text("testNetErrorAsync"),
            ),
          ],
        ),
      ),
    );
  }
}
