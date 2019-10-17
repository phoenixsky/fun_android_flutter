import 'package:fun_android/config/net/wan_android_api.dart';
import 'package:fun_android/model/article.dart';
import 'package:fun_android/model/banner.dart';
import 'package:fun_android/model/coin_record.dart';
import 'package:fun_android/model/search.dart';
import 'package:fun_android/model/navigation_site.dart';
import 'package:fun_android/model/tree.dart';
import 'package:fun_android/model/user.dart';

class WanAndroidRepository {
  // 轮播
  static Future fetchBanners() async {
    var response = await http.get('banner/json');
    return response.data
        .map<Banner>((item) => Banner.fromJsonMap(item))
        .toList();
  }

  // 置顶文章
  static Future fetchTopArticles() async {
    var response = await http.get('article/top/json');
    return response.data.map<Article>((item) => Article.fromMap(item)).toList();
  }

  // 文章
  static Future fetchArticles(int pageNum, {int cid}) async {
    await Future.delayed(Duration(seconds: 1)); //增加动效
    var response = await http.get('article/list/$pageNum/json',
        queryParameters: (cid != null ? {'cid': cid} : null));
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  // 项目分类
  static Future fetchTreeCategories() async {
    var response = await http.get('tree/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  // 体系分类
  static Future fetchProjectCategories() async {
    var response = await http.get('project/tree/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  // 导航
  static Future fetchNavigationSite() async {
    var response = await http.get('navi/json');
    return response.data
        .map<NavigationSite>((item) => NavigationSite.fromMap(item))
        .toList();
  }

  // 公众号分类
  static Future fetchWechatAccounts() async {
    var response = await http.get('wxarticle/chapters/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  // 公众号文章
  static Future fetchWechatAccountArticles(int pageNum, int id) async {
    var response = await http.get('wxarticle/list/$id/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  // 搜索热门记录
  static Future fetchSearchHotKey() async {
    var response = await http.get('hotkey/json');
    return response.data
        .map<SearchHotKey>((item) => SearchHotKey.fromMap(item))
        .toList();
  }

  // 搜索结果
  static Future fetchSearchResult({key = "", int pageNum = 0}) async {
    var response =
        await http.post<Map>('article/query/$pageNum/json', queryParameters: {
      'k': key,
    });
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  /// 登录
  /// [Http._init] 添加了拦截器 设置了自动cookie.
  static Future login(String username, String password) async {
    var response = await http.post<Map>('user/login', queryParameters: {
      'username': username,
      'password': password,
    });
    return User.fromJsonMap(response.data);
  }

  /// 注册
  static Future register(
      String username, String password, String rePassword) async {
    var response = await http.post<Map>('user/register', queryParameters: {
      'username': username,
      'password': password,
      'repassword': rePassword,
    });
    return User.fromJsonMap(response.data);
  }

  /// 登出
  static logout() async {
    /// 自动移除cookie
    await http.get('user/logout/json');
  }

  static testLoginState() async {
    await http.get('lg/todo/listnotdo/0/json/1');
  }

  // 收藏列表
  static Future fetchCollectList(int pageNum) async {
    var response = await http.get<Map>('lg/collect/list/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  // 收藏
  static collect(id) async {
    await http.post('lg/collect/$id/json');
  }

  // 取消收藏
  static unCollect(id) async {
    await http.post('lg/uncollect_originId/$id/json');
  }

  // 取消收藏2
  static unMyCollect({id, originId}) async {
    await http.post('lg/uncollect/$id/json',
        queryParameters: {'originId': originId ?? -1});
  }

  // 个人积分
  static Future fetchCoin() async {
    var response = await http.get('lg/coin/getcount/json');
    return response.data;
  }

  // 我的积分记录
  static Future fetchCoinRecordList(int pageNum) async {
    var response = await http.get('lg/coin/list/$pageNum/json');
    return response.data['datas']
        .map<CoinRecord>((item) => CoinRecord.fromMap(item))
        .toList();
  }

  // 积分排行榜
  /// {
  ///        "coinCount": 448,
  ///        "username": "S**24n"
  ///      },
  static Future fetchRankingList(int pageNum) async {
    var response = await http.get('coin/rank/$pageNum/json');
    return response.data['datas'];
  }
}
