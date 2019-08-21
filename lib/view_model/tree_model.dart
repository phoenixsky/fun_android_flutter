import 'package:fun_android/provider/base_list_model.dart';
import 'package:fun_android/provider/sample_list_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

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

  @override
  void dispose() {
    super.dispose();
  }
}

/// 网址导航
class NavigationSiteModel extends SampleListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchNavigationSite();
  }
}

