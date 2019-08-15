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

const List<String> settingItems = ['收藏',  '黑夜模式', '色彩主题', '设置', '关于我'];

const List<IconData> settingLeadingIcons = [
  Icons.favorite_border,
//  Icons.bookmark_border,
  Icons.brightness_3,
  Icons.color_lens,
  Icons.settings,
  Icons.error_outline,
];

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      if (index == 2) {
        return SettingThemeWidget(index);
      }
      return ListTile(
        title: Text(settingItems[index]),
        isThreeLine: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        onTap: () {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed(RouteName.collectionList);
              break;
            case 1:
              break;
            case 2:
              break;
            case 4:
              break;
          }
        },
        leading: Icon(
          settingLeadingIcons[index],
          color: Theme.of(context).accentColor,
        ),
        trailing: Builder(
          builder: (context) {
            /// 黑夜模式开关
            if (index == 1) {
              return CupertinoSwitch(
                  activeColor: Theme.of(context).accentColor,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    Provider.of<ThemeModel>(context).switchTheme(
                        brightness: value ? Brightness.dark : Brightness.light);
                  });
            }
            return Icon(Icons.chevron_right);
          },
        ),
      );
    }, childCount: settingItems.length));
  }
}

class SettingThemeWidget extends StatelessWidget {
  final int index;

  SettingThemeWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ExpansionTile(
        title: Text(settingItems[index]),
        leading: Icon(
          settingLeadingIcons[index],
          color: Theme.of(context).accentColor,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                ...Colors.primaries.map((color) {
                  return Material(
                    color: color,
                    child: InkWell(
                      onTap: () {
                        var model = Provider.of<ThemeModel>(context);
                        var brightness = Theme.of(context).brightness;
                        model.switchTheme(brightness: brightness, color: color);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                      ),
                    ),
                  );
                }).toList(),
                Material(
                  child: InkWell(
                    onTap: () {
                      var model = Provider.of<ThemeModel>(context);
                      var brightness = Theme.of(context).brightness;
                      model.switchRandomTheme(brightness: brightness);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).accentColor)),
                      width: 40,
                      height: 40,
                      child: Text(
                        "?",
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
