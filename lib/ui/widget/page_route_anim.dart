import 'package:flutter/cupertino.dart';

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;

  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}

class FadeRouteBuilder extends PageRouteBuilder {
  final Widget page;

  FadeRouteBuilder(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 1400),
            transitionsBuilder: (context, animation, secondaryAnimation,
                    child) =>
                FadeTransition(
                  //渐变过渡 0.0-1.0
                  opacity: Tween(begin: 0.5, end: 0.0).animate(CurvedAnimation(
                    parent: animation, //动画样式
                    curve: Curves.fastOutSlowIn, //动画曲线
                  )),
                  child: child,
                ));
//                FadeTransition(opacity: animation, child: child));
}

class SizeRoute extends PageRouteBuilder {
  final Widget page;

  SizeRoute(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//                Align(
//                  child: SizeTransition(child: child, sizeFactor: animation),
//                ),
              ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          ),
        );
}
