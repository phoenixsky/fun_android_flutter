import 'package:fun_android/model/article.dart';
import 'package:fun_android/model/tree.dart';
import 'package:fun_android/provider/base_list_model.dart';
import 'package:fun_android/provider/sample_list_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

/// 微信公众号
class WechatAccountCategoryModel extends SampleListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await WanAndroidRepository.fetchWechatAccounts();
  }
}

/// 微信公众号文章
class WechatArticleListModel extends BaseListModel<Article> {
  /// 公众号id
  final int id;

  WechatArticleListModel(this.id);

  @override
  Future<List<Article>> loadData(int pageNum) async {
    return await WanAndroidRepository.fetchWechatAccountArticles(pageNum, id);
  }
}
