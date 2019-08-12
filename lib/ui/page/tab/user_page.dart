import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/config/resource_mananger.dart';
import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/ui/widget/bottom_clipper.dart';
import 'package:wan_android/view_model/theme_model.dart';
import 'package:wan_android/view_model/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            Consumer<UserModel>(
                builder: (context, model, child) => Offstage(
                      offstage: !model.isLogin,
                      child: IconButton(
                        tooltip: '退出登录',
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          model.logout();
                        },
                      ),
                    ))
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 240,
          flexibleSpace: UserHeaderWidget(),
          pinned: false,
        ),
        UserListWidget(),
      ],
    ));
  }
}

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('UserHeaderWidget');
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        color: Theme.of(context).primaryColor.withAlpha(200),
        padding: EdgeInsets.only(top: 10),
        child: Consumer<UserModel>(
            builder: (context, model, child) => InkWell(
                  onTap: model.isLogin
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(RouteName.login);
                        },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: InkWell(
                          child: Image.asset(
                              ImageHelper.wrapAssets('user_avatar.png'),
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                              color: model.isLogin
                                  ? Theme.of(context).accentColor.withAlpha(200)
                                  : Theme.of(context).accentColor.withAlpha(10),
                              // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                              colorBlendMode: BlendMode.colorDodge),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(model.isLogin ? model.user.nickname : '点我登录',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .apply(color: Colors.white.withAlpha(200))),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: model.isLogin,
                        maintainState: true,
                        maintainSize: true,
                        maintainAnimation: true,
                        child: Text('ID: ${model.user?.id.toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .apply(color: Colors.white.withAlpha(200))),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  static const List<String> items = ['收藏', '稍后阅读', '开源项目', '色彩主题', '设置', '关于我'];
  static const List<IconData> icons = [
    Icons.favorite_border,
    Icons.bookmark_border,
    Icons.format_list_bulleted,
    Icons.color_lens,
    Icons.settings,
    Icons.error_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
        itemExtent: 60,
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text(items[index]),
                  isThreeLine: false,
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.of(context)
                            .pushNamed(RouteName.collectionList);
                        break;
                      case 1:
                        break;
                      case 2:
                        break;
                      case 3:
                        Provider.of<ThemeModel>(context).switchRandomTheme();
                        break;
                      case 4:
                        break;
                    }
                  },
                  leading: Icon(
                    icons[index],
                    color: Theme.of(context).accentColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
            childCount: items.length));
  }
}
