import 'package:fun_android/model/article.dart';
import 'package:fun_android/model/banner.dart';
import 'package:fun_android/provider/base_list_model.dart';
import 'package:fun_android/service/wan_android_repository.dart';

class HomeModel extends BaseListModel {
  List<Banner> _banners;
  List<Article> _topArticles;

  List<Banner> get banners => _banners;

  List<Article> get topArticles => _topArticles;

  @override
  Future<List> loadData(int pageNum) async {
    List<Future> futures = [];
    if (pageNum == BaseListModel.pageNumFirst) {
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == BaseListModel.pageNumFirst) {
      _banners = result[0];
      _topArticles = result[1];
      return result[2];
    } else {
      return result[0];
    }

//    if (pageNum == BaseListModel.pageNumFirst) {
//      _banners = await WanAndroidRepository.fetchBanners();
//      _topArticles = await WanAndroidRepository.fetchTopArticles();
//    }
//    return await WanAndroidRepository.fetchArticles(pageNum);
  }
}
