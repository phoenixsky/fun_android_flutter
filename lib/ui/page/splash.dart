import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_android/config/router_config.dart';

import 'package:wan_android/config/resource_mananger.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween(begin: 0.1, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
//        if (status == AnimationStatus.completed) {
//          _controller.reverse();
//        } else if (status == AnimationStatus.dismissed) {
//          nextPage(context);
//        }
    });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(ImageHelper.wrapAssets('splash_bg.png'), fit: BoxFit.fill),
        Align(
          alignment: Alignment(0.0, 0.47),
          child: RotationTransition(
            turns: _animation,
            child: Image.asset(
              ImageHelper.wrapAssets('ic_launcher.png'),
              width: 140,
              height: 140,
              color: Theme.of(context).primaryColor,
              colorBlendMode: BlendMode.color,
            ),
          ),
        ),
      ]),
    );
  }
}

const firstEntry = 'firstEntry';

void nextPage(context) async {
  var sharedPreferences = await SharedPreferences.getInstance();

//  Route nextRoute = sharedPreferences.getBool(firstEntry) ?? true
//      ? SizeRoute(GuidePage())
//      : SizeRoute(LoginPage());

//  Navigator.of(context).pushReplacement(nextRoute);
  Navigator.of(context).pushReplacementNamed(RouteName.tab);
}

class GuidePage extends StatefulWidget {
  static const List<String> images = <String>[
    'guide_page_1.png',
    'guide_page_2.png',
    'guide_page_3.png',
    'guide_page_4.png'
  ];

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        alignment: Alignment(0, 0.87),
        children: <Widget>[
          Swiper(
              itemBuilder: (ctx, index) => Image.asset(
                    'assets/images/${GuidePage.images[index]}',
                    fit: BoxFit.fill,
                  ),
              itemCount: GuidePage.images.length,
              loop: false,
              onIndexChanged: (index) {
                setState(() {
                  curIndex = index;
                });
              }),
          Offstage(
            offstage: curIndex != GuidePage.images.length - 1,
            child: CupertinoButton(
              color: Theme.of(context).primaryColorDark,
              child: Text('点我开始'),
              onPressed: () {
                SharedPreferences.getInstance()
                    .then((sp) => sp.setBool(firstEntry, false));
                nextPage(context);
              },
            ),
          )
        ],
      ),
    ));
  }
}
