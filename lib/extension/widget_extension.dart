import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// @author phoenixsky
/// @date 2021/5/21
/// @email moran.fc@gmail.com
/// @github https://github.com/phoenixsky
/// @group fun flutter

extension ColumnScroll on Widget {
  Widget get expandScroll => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height - Get.statusBarHeight,
          ),
          child: IntrinsicHeight(child: this),
        ),
      );
}
