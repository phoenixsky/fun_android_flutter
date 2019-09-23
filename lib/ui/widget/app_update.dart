import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/provider/provider_widget.dart';
import 'package:fun_android/view_model/app_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_file/open_file.dart';
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
            : Text(S.of(context).appUpdateCheckUpdate),
        onPressed: model.busy
            ? null
            : () async {
          String url = await model.checkUpdate();
          if (url?.isNotEmpty ?? false) {
            bool result = await showUpdateAlertDialog(context,url.split('/').last);
            if (result == true) downloadApp(context, url);
          } else {
            showToast(S.of(context).appUpdateLeastVersion);
          }
        },
      ),
    );
  }
}

Future checkAppUpdate(BuildContext context) async {
  if (!Platform.isAndroid) {
    return;
  }
  String url = await AppUpdateModel().checkUpdate();
  if (url?.isNotEmpty ?? false) {
    bool result = await showUpdateAlertDialog(context, url.split('/').last);
    if (result == true) downloadApp(context, url);
  }
}

/// App更新提示框
showUpdateAlertDialog(context, version) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(S.of(context).appUpdateFoundNewVersion(version)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: new Text(
              S.of(context).actionCancel,
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          FlatButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: new Text(S.of(context).appUpdateActionUpdate),
          ),
        ],
      ));
}

Future downloadApp(BuildContext context, String url) async {
  var externalDirectory = await getExternalStorageDirectory();
  String apkPath = externalDirectory.path + '/' + url.split('/').last;
  File file = File(apkPath);
  debugPrint('file path: ${file.path}');
  if (!file.existsSync()) {
    // 没有下载过
    if (await showDownloadDialog(context, url, apkPath) ?? false) {
      OpenFile.open(apkPath);
    }
  } else {
    var reDownload = await showReDownloadDialog(context);
    //因为点击android的返回键,关闭dialog时的返回值为null
    if (reDownload != null) {
      if (reDownload) {
        //重新下载
        if (await showDownloadDialog(context, url, apkPath) ?? false) {
          OpenFile.open(apkPath);
        }
      } else {
        //直接安装
        OpenFile.open(apkPath);
      }
    }
  }
}

showDownloadDialog(context, url, path) async {
  CancelToken cancelToken = CancelToken();
  DateTime lastBackPressed;
  return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (lastBackPressed == null ||
                DateTime.now().difference(lastBackPressed) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              lastBackPressed = DateTime.now();
              showToast('再次点击返回键,取消下载', position: ToastPosition.bottom);
              return false;
            }
            cancelToken.cancel();
            showToast('下载已取消', position: ToastPosition.bottom);
            return true;
          },
          child: CupertinoAlertDialog(
            title: Text('正在下载'),
            content: Builder(
              builder: (context) {
                ValueNotifier notifier = ValueNotifier(0.0);
                Dio().download(url, path, cancelToken: cancelToken,
                    onReceiveProgress: (progress, total) {
                      debugPrint('value--${progress / total}');
                      notifier.value = progress / total;
                      if (notifier.value == 1) {
                        Navigator.pop(context, true);
                      }
                    });
                return ValueListenableBuilder(
                  valueListenable: notifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: value,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      });
}

showReDownloadDialog(context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(S.of(context).appUpdateReDownloadContent),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).actionCancel,
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
              S.of(context).appUpdateActionDownloadAgain,
              style: TextStyle(color: Colors.black),
            ),
          ),
          FlatButton(
            onPressed: () async {
              Navigator.of(context).pop(false);
            },
            child: Text(S.of(context).appUpdateActionInstallApk),
          ),
        ],
      ));
}
