import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/utils/platform_utils.dart';
import 'package:fun_android/view_model/app_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_file/open_file.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart';

import 'button_progress_indicator.dart';

class AppUpdateButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return ProviderWidget<AppUpdateModel>(
      model: AppUpdateModel(),
      builder: (_, model, __) => CupertinoButton(
        color: Theme.of(context).accentColor,
        child: model.busy
            ? ButtonProgressIndicator()
            : Text(S.of(context).checkUpdate),
        onPressed: model.busy
            ? null
            : () async {
                String url = await model.checkUpdate();
                if (url != null) {
                  bool result = await showUpdateDialog(context);
                  if (result == true) downloadApp(context, url);
                } else {
                  showToast(S.of(context).leastVersion);
                }
              },
      ),
    );
  }
}

Future downloadApp(BuildContext context, String url) async {
  var externalDirectory = await getExternalStorageDirectory();
  String apkPath = externalDirectory.path + '/' + url.split('/').last;
  File file = File(apkPath);
  if (!file.existsSync()) {
    // 没有下载过
    await showDownloadDialog(context, url, apkPath);
    OpenFile.open(apkPath);
  } else {
    var reDownload = await showReDownloadDialog(context);
    //因为点击android的返回键,关闭dialog时的返回值为null
    if (reDownload != null) {
      if (reDownload) {
        await showDownloadDialog(context, url, apkPath);
      }
      OpenFile.open(apkPath);
    }
  }
}

showDownloadDialog(context, url, path) async {
  /// TODO ProgressDialog目前无法监听dialog的关闭事件,导致无法配合cancel下载的操作
  /// 需要重新实现
  ProgressDialog dialog = ProgressDialog(context,
      type: ProgressDialogType.Download, isDismissible: !inProduction);
  dialog.show();
  await Dio().download(url, path, onReceiveProgress: (progress, total) {
    if (total != -1) {
      dialog.update(
          progress: double.parse((progress / total * 100).toStringAsFixed(2)),
          maxProgress: 100,
          message: S.of(context).downloadApk);
    }
  });
  dialog.dismiss();
}

showReDownloadDialog(context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(S.of(context).reDownloadApkContent),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  S.of(context).downloadAgain,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
                child: Text(S.of(context).installApk),
              ),
            ],
          ));
}

/// App更新提示框
showUpdateDialog(context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(S.of(context).newVersion),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(
                  S.of(context).cancel,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: new Text(S.of(context).action_update),
              ),
            ],
          ));
}
