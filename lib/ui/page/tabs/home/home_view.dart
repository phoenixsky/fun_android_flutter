import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:funflutter_wanandroid/ui/widget/anmiated_widgets.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late HomeLogic logic;

  @override
  Widget build(BuildContext context) {
    logic = Get.put(HomeLogic());

    return _buildContainer(children: [
      _buildAppBar(),
      _buildHomeList(),
    ]);
  }

  Widget _buildContainer({required List<Widget> children}) {
    return Scaffold(
      body: CustomScrollView(
        controller: logic.scrollController,
        slivers: children,
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      // 保证划到顶部显示AppBar
      pinned: true,
      expandedHeight: logic.bannerHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Banner(),
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, bottom: 16),
        title: Obx(() {
          return FadeOutSwitcher(
              isVisible: logic.isAppBarCollapsed.value,
              child: const Text(
                "玩Android",
                style: TextStyle(color: Colors.black),
              ));
        }),
      ),
      actions: [
        Obx(() {
          return FadeOutSwitcher(
            isVisible: logic.isAppBarCollapsed.value,
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          );
        })
      ],
    );
  }

  SliverList _buildHomeList() {
    return SliverList.builder(
        itemCount: 1000,
        itemBuilder: (context, index) => Container(
              color: Colors.amber[100 * (index % 10)],
              height: 100,
              child: Text("index$index"),
            ));
  }
}

class Banner extends StatelessWidget {
  Banner({super.key});

  final logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    String url =
        "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png";
    return SizedBox(
        width: Get.width,
        height: logic.bannerHeight,
        child: Swiper(
          itemBuilder: (ctx, index) =>
              ExtendedImage.network(url, fit: BoxFit.fill),
          itemCount: 3,
          pagination: const SwiperPagination(),
        ));
  }
}
