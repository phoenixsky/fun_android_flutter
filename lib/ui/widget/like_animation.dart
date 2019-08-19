import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/view_model/colletion_model.dart';

class LikeAnimatedWidget extends StatelessWidget {
  static const kAnimNameLike = 'like';
  static const kAnimNameUnLike = 'Heart Break';

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CollectionAnimationModel>(context);
    if (model.playing) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 300,
          child: FlareActor(
            model.like
                ? "assets/animations/like.flr"
                : "assets/animations/unLike.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: model.like ? kAnimNameLike : kAnimNameUnLike,
            shouldClip: false,
            callback: (name) {
              model.pause();
//              switch (name) {
//                case kAnimNameUnLike:
//                  model.pause();
//                  break;
//              }
            },
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }
}
