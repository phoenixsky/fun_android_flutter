import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android/config/router_config.dart';

class DialogHelper {
  static showLoginDialog(context) async {
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('请先登录'),
              content: Text('还没有登录,请先登录..'),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      new Text("取消", style: Theme.of(context).textTheme.button),
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..pushNamed(RouteName.login);
                  },
                  child: new Text(
                    "确认",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ));
  }
}
