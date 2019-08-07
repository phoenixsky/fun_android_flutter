import 'package:wan_android/model/article.dart';
import 'package:wan_android/model/banner.dart';
import 'package:wan_android/provider/base_list_model.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class HomeModel extends BaseListModel {
  List<Banner> _banners;
  List<Article> _topArticles;

  List<Banner> get banners => _banners;
  List<Article> get topArticles => _topArticles;

  @override
  Future<List> loadData(int pageNum) async {
    // Future.wait([HomeService.fetchBanners(), HomeService.fetchArticles(0)])
    if (pageNum == BaseListModel.pageNumFirst) {
      _banners = await WanAndroidRepository.fetchBanners();
      _topArticles = await WanAndroidRepository.fetchTopArticles();
    }
    return await WanAndroidRepository.fetchArticles(pageNum);
  }
}
