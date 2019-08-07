import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class TreeCategoryModel extends BaseListModel {
  @override
  Future<List> loadData(int pageNum) async {
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
