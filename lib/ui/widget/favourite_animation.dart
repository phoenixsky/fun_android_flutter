import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

const kAnimAddFavouritesTag = 'kAnimAddFavouritesTag';

class FavouriteAnimationWidget extends StatefulWidget {
  /// Hero动画的唯一标识
  final Object tag;

  /// true 添加到收藏,false从收藏移除
  final bool add;

  FavouriteAnimationWidget({@required this.tag, @required this.add});

  @override
  _FavouriteAnimationWidgetState createState() =>
      _FavouriteAnimationWidgetState();
}

class _FavouriteAnimationWidgetState extends State<FavouriteAnimationWidget> {
  bool playing = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        playing = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      child: FlareActor(
        "assets/animations/like.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: widget.add ? 'like' : 'unLike',
        shouldClip: false,
        isPaused: !playing,
        callback: (name) {
          Navigator.pop(context);
          playing = false;
        },
      ),
    );
  }
}

/// Dialog下使用Hero动画的路由
class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 800);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black12;

//  @override
//  Widget buildTransitions(BuildContext context, Animation<double> animation,
//      Animation<double> secondaryAnimation, Widget child) {
//    return new FadeTransition(
//        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeIn),
//        child: child);
//  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => null;
}
