import 'package:flutter/material.dart';

class SkeletonCard extends StatefulWidget {
  final bool hasImage;
  final bool isCircularImage;
  final bool isBottomLinesActive;

  SkeletonCard(
      {this.hasImage = true,
      this.isCircularImage = true,
      this.isBottomLinesActive = true});

  @override
  _SkeletonCardState createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 15,
                top: !widget.hasImage ? 5 : 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Offstage(
                      offstage: !widget.hasImage,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: width * 0.13,
                          width: width * 0.13,
                          decoration: boxDecoration(context, animation,
                              isCircle: widget.isCircularImage),
                        ),
                      ),
                    ),
                    Container(
                      height: width * (widget.hasImage ? 0.13 : 0.11),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: height * 0.008,
                            width: width * 0.3,
                            decoration: boxDecoration(context, animation),
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.2,
                            decoration: boxDecoration(context, animation),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Offstage(
                  offstage: !widget.isBottomLinesActive,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: widget.hasImage ? 15 : 0,
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.7,
                        decoration: boxDecoration(context, animation),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.8,
                        decoration: boxDecoration(context, animation),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.5,
                        decoration: boxDecoration(context, animation),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SkeletonCardList extends StatelessWidget {
  final bool hasImage;
  final bool isCircularImage;
  final bool isBottomLinesActive;
  final int length;
  final double itemPadding;
  final EdgeInsetsGeometry padding;

  SkeletonCardList(
      {this.hasImage = true,
      this.isCircularImage = true,
      this.isBottomLinesActive = true,
      this.length = 10,
      this.itemPadding = 0,
      this.padding = const EdgeInsets.all(7)});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: length,
      padding: padding,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(bottom: itemPadding),
          child: SkeletonCard(
            isCircularImage: isCircularImage,
            isBottomLinesActive: isBottomLinesActive,
            hasImage: hasImage,
          ),
        );
      },
    );
  }
}

class SkeletonProfileCard extends StatefulWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;

  SkeletonProfileCard(
      {this.isCircularImage = true, this.isBottomLinesActive = true});

  @override
  _SkeletonProfileCardState createState() => _SkeletonProfileCardState();
}

class _SkeletonProfileCardState extends State<SkeletonProfileCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  decoration: boxDecoration(context, animation,
                      isCircle: widget.isCircularImage),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (i) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: width * 0.13,
                                width: width * 0.13,
                                decoration: boxDecoration(context, animation,
                                    isCircle: widget.isCircularImage),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: width * 0.13,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: height * 0.008,
                                      width: width * 0.3,
                                      decoration:
                                          boxDecoration(context, animation),
                                    ),
                                    Container(
                                      height: height * 0.007,
                                      width: width * 0.2,
                                      decoration:
                                          boxDecoration(context, animation),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                    ).toList(),
                  ),
                ),
                widget.isBottomLinesActive
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.7,
                            decoration: boxDecoration(context, animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.8,
                            decoration: boxDecoration(context, animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.5,
                            decoration: boxDecoration(context, animation),
                          ),
                        ],
                      )
                    : Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

Decoration boxDecoration(context, animation, {isCircle = false}) {
  bool isLight = Theme.of(context).brightness == Brightness.light;
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        isLight ? Color(0xfff6f7f9) : Colors.grey[700],
        isLight ? Color(0xffe9ebee) : Colors.grey[600],
        isLight ? Color(0xfff6f7f9) : Colors.grey[700],
        // Color(0xfff6f7f9),
      ],
      stops: [
        // animation.value * 0.1,
        animation.value - 1,
        animation.value,
        animation.value + 1,
        // animation.value + 5,
        // 1.0,
      ],
    ),
  );
}
