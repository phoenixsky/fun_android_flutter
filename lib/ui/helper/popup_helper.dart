import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 待完成替换现有tabBar展开

Future showPopup({
  @required BuildContext context,
//  @required RelativeRect position,
  @required Widget child,
}) {
  assert(context != null);
//  assert(position != null);
  assert(debugCheckHasMaterialLocalizations(context));
  return Navigator.push(
      context, PopupWindowRoute(target: context, child: child));
}

class PopupWindowRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  final Widget child;
  final BuildContext target;

  PopupWindowRoute({
    @required this.child,
    @required this.target,
  });

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => _duration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, 2.0 / 3.0),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final RenderBox button = target.findRenderObject();
    final RenderBox overlay = Overlay.of(target).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: PopupMenuRouteLayout(
              position,
              null,
              Directionality.of(context),
            ),
            child: Material(child: child),
          );
        },
      ),
    );
//    return Material(
//      color: Colors.transparent,
//      child: GestureDetector(
//          child: Stack(
//            children: <Widget>[
//              Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                color: Colors.transparent,
//              ),
//              Positioned(
//                top: 100,
//                right: 0,
//                left: 0,
//                height: 200,
//                child: AnimatedBuilder(
//                  animation: animation,
//                  builder: (context, child) {
//                    return Opacity(
//                        opacity: animation.value,
//                        child: Material(
//                          type: MaterialType.card,
//                          color: Colors.red,
//                          child: Align(
//                              alignment: AlignmentDirectional.topStart,
//                              widthFactor: CurveTween(curve: Interval(0.0, 1))
//                                  .evaluate(animation),
//                              heightFactor: CurveTween(curve: Interval(0.5, 1))
//                                  .evaluate(animation),
//                              child: child),
//                        ));
//                  },
//                  child: child,
//                ),
//              )
//            ],
//          ),
//          onTap: () {
//            Navigator.of(context).pop();
//          }),
//    );
  }
}

const double _kMenuScreenPadding = 8.0;

// Positioning of the menu on the screen.
class PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  PopupMenuRouteLayout(
      this.position, this.selectedItemOffset, this.textDirection);

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The distance from the top of the menu to the middle of selected item.
  //
  // This will be null if there's no item to position in this way.
  final double selectedItemOffset;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest -
        const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y;
    if (selectedItemOffset == null) {
      y = position.top;
    } else {
      y = position.top +
          (size.height - position.top - position.bottom) / 2.0 -
          selectedItemOffset;
    }

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(PopupMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
