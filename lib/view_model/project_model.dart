import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';



class ProjectCategoryModel extends BaseListModel {
  @override
  Future<List> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchProjectCategories();
  }
}

class ProjectListModel extends BaseListModel {
  @override
  Future<List> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: 294);
  }
}
