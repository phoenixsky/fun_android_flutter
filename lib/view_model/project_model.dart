import 'package:fun_android/model/article.dart';
import 'package:fun_android/model/tree.dart';
import 'package:fun_android/provider/base_list_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

class ProjectCategoryModel extends BaseListModel<Tree> {
  @override
  Future<List<Tree>> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchProjectCategories();
  }
}

class ProjectListModel extends BaseListModel<Article> {
  @override
  Future<List<Article>> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: 294);
  }
}
