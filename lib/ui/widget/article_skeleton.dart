import 'package:flutter/material.dart';

import 'skeleton.dart';

class ArticleSkeletonItem extends StatelessWidget {
  final int index;

  ArticleSkeletonItem({this.index: 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,
                  width: 0.7, color: Colors.redAccent))),
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
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 100,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 30,
                decoration: SkeletonDecoration(isDark: isDark),
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
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.8,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.5,
                decoration: SkeletonDecoration(isDark: isDark),
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
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Container(
                height: 8,
                width: 80,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 20,
                width: 20,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
