import 'dart:io';
import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

const bool inProduction = const bool.fromEnvironment("dart.vm.product");

class PlatformUtils {


  static String getPlatform() => Platform.operatingSystem;

  static bool isAndroid() => Platform.isAndroid;

  static bool isIOS() => Platform.isIOS;

  static String getFlutterVersion() => Platform.version;

  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid()) {
      return await deviceInfo.androidInfo;
    } else if (isIOS()) {
      return await deviceInfo.iosInfo;
    } else {
      return null;
    }
  }
}
