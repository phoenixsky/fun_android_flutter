import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android/model/article.dart';
import 'package:wan_android/model/tree.dart';
import 'package:wan_android/ui/page/collection_list_page.dart';
import 'package:wan_android/ui/page/tree_list_page.dart';
import 'package:wan_android/ui/page/user/login_page.dart';
import 'package:wan_android/ui/page/splash.dart';
import 'package:wan_android/ui/page/tab/tab_navigator.dart';
import 'package:wan_android/ui/page/webview.dart';
import 'package:wan_android/ui/widget/page_route_anim.dart';

class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String login = 'login';
  static const String webView = 'webView';
  static const String treeList = 'treeList';
  static const String collectionList = 'collectionList';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.login:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.webView:
        var article = settings.arguments as Article;
        return MaterialPageRoute(
            builder: (_) => ArticleWebView(
                  article: article,
                ));
      case RouteName.treeList:
        var list = settings.arguments as List;
        Tree tree = list[0] as Tree;
        int index = list[1];
        return MaterialPageRoute(builder: (_) => TreeListTabPage(tree, index));
      case RouteName.collectionList:
        return MaterialPageRoute(builder: (_) => CollectionListPage());
//      case RoutePaths.Post:
//        var post = settings.arguments as Post;
//        return MaterialPageRoute(builder: (_) => PostView(post: post));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
