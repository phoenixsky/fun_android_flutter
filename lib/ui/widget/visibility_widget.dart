import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// 1、（visible)显示
///
/// 2、（invisible)隐藏：
///
///  这种隐藏是指在屏幕中占据空间，只是没有显示。这种情况出现场景如：用带有背景色的Container Widget去包含一个不可见的Image，当从网络中加载图片后才让它显示，这是为了避免图片显示后让页面布局改变发生跳动。
///
/// 3、（Offscreen)超出屏幕，同样占据空间
///
/// 4、（Gone)消失：
enum Visibility {
  visible,
  invisible,
  offscreen,
  gone,
}

class VisibilityWidget extends StatelessWidget {
  final Visibility visibility;
  final Widget child;
  final Widget removeChild;

  VisibilityWidget({
    @required this.child,
    @required this.visibility,
  }) : this.removeChild = Container();

  @override
  Widget build(BuildContext context) {
    if (visibility == Visibility.visible) {
      return child;
    } else if (visibility == Visibility.invisible) {
      return IgnorePointer(
          ignoring: true, child: Opacity(opacity: 0.0, child: child));
    } else if (visibility == Visibility.offscreen) {
      return new Offstage(offstage: true, child: child);
    } else {
      return removeChild;
    }
  }
}
