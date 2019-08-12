import 'dart:async';

import 'package:flutter/material.dart';

class SkeletonListItem extends StatefulWidget {
  final int index;

  SkeletonListItem({this.index: 0});

  @override
  _SkeletonListItemState createState() => _SkeletonListItemState();
}

class _SkeletonListItemState extends State<SkeletonListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    Timer(Duration(milliseconds: widget.index * 80), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        bool isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: Divider.createBorderSide(context, width: 0.5))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    decoration: SkeletonDecoration(
                        animation: animation, isCircle: true, isDark: isDark),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: 100,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Container(
                    height: 5,
                    width: 30,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                ],
              ),
              SizedBox(
                height: 0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 6.5,
                    width: width * 0.7,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 6.5,
                    width: width * 0.8,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 6.5,
                    width: width * 0.5,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 8,
                    width: 20,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                  Container(
                    height: 8,
                    width: 80,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: SkeletonDecoration(
                        animation: animation, isDark: isDark),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SkeletonDecoration extends BoxDecoration {
  SkeletonDecoration({
    Animation animation,
    isCircle: false,
    isDark: false,
  }) : super(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                !isDark ? Colors.grey[200] : Colors.grey[700],
                !isDark ? Colors.grey[350] : Colors.grey[500],
                !isDark ? Colors.grey[200] : Colors.grey[700],
              ],
              stops: [
                animation.value - 1,
                animation.value,
                animation.value + 1,
              ],
            ));
}

class SkeletonList extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int length;

  SkeletonList({this.length, this.padding = const EdgeInsets.all(7)});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: length,
      padding: padding,
      itemBuilder: (BuildContext context, int index) {
        return SkeletonListItem();
      },
    );
  }
}
