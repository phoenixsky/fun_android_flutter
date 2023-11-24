import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_setting_logic.dart';

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(UserSettingLogic());

    return Container();
  }
}
