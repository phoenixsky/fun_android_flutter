import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/provider/sample_list_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class TreeCategoryModel extends SampleListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchTreeCategories();
  }
}

class TreeListModel extends BaseListModel {
  final int cid;

  TreeListModel(this.cid);

  @override
  Future<List> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: cid);
  }
}

/// 网址导航
class NavigationSiteModel extends SampleListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchNavigationSite();
  }
}
/// 获取微信公众号列表
class WxArticleCategoryModel extends SampleListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchWxMpCategories();
  }
}
