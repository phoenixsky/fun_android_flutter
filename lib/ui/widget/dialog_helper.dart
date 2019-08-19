import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/config/router_config.dart';

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
                    Navigator.of(context).pop(false);
                  },
                  child: new Text(
                    "取消",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                CupertinoButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  child: new Text("确认", style: TextStyle(color: Colors.black)),
                ),
              ],
            ));
  }
}
