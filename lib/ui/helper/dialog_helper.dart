import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/generated/i18n.dart';

class DialogHelper {
  static showLoginDialog(context) async {
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(S.of(context).needLogin),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: new Text(
                    S.of(context).cancel,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                CupertinoButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  child: new Text(S.of(context).confirm,
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ));
  }
}


