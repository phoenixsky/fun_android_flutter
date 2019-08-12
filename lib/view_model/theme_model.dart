import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_android/ui/widget/theme.dart';
import 'package:wan_android/config/storage_manager.dart';

//const Color(0xFF5394FF),

class ThemeModel with ChangeNotifier {
  static const keyThemeColorIndex = 'keyThemeColorIndex';
  static const keyThemeBrightnessIndex = 'keyThemeBrightnessIndex';

  ThemeData _themeData;

  ThemeModel() {
    var value = getThemeFromStorage();
    _themeData = _generateThemeData(value[0], value[1]);
  }

  ThemeData get value => _themeData;

  ThemeData get darkTheme => _themeData.copyWith(brightness: Brightness.dark);

  /// 切换主题色彩
  void switchTheme(Brightness brightness, int index) {
    _themeData = _generateThemeData(brightness, index);
    notifyListeners();
    saveTheme2Storage(brightness, index);
  }

  /// 随机一个主题色彩
  void switchRandomTheme() {
    Brightness brightness =
        Random().nextBool() ? Brightness.dark : Brightness.light;
    int index = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(brightness, index);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  ThemeData _generateThemeData(Brightness brightness, int colorIndex) {
    debugPrint('brightness--' + brightness.toString());

    var themeColor = Colors.primaries[colorIndex];
    var isDark = Brightness.dark == brightness;
    var themeData = ThemeData(
      brightness: brightness,

      /// 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle的颜色为白色,反之为黑色)
      primaryColorBrightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primarySwatch: Colors.primaries[colorIndex],
//      accentColor: Colors.accents[colorIndex][400],
//      accentColor: isDark ? Colors.accents[colorIndex][700] : null,
      accentColor: isDark ? Colors.primaries[colorIndex][700] : null,
    );

    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: themeColor,
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
//      tabBarTheme: themeData.tabBarTheme.copyWith(),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: themeColor,
      textSelectionColor: themeColor.withAlpha(60),
      textSelectionHandleColor: themeColor.withAlpha(60),

      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),

      cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: themeColor,
          brightness: brightness,
          textTheme: CupertinoTextThemeData(brightness: Brightness.light)),
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );

    return themeData;
  }

  /// 数据持久化到shared preferences
  static saveTheme2Storage(Brightness brightness, int index) async {
    await Future.wait([
      StorageManager.sharedPreferences
          .setInt(keyThemeBrightnessIndex, brightness.index),
      StorageManager.sharedPreferences.setInt(keyThemeColorIndex, index)
    ]);
  }

  /// 从shared preferences取出数据
  static getThemeFromStorage() {
    var brightness = Brightness.values[
        StorageManager.sharedPreferences.getInt(keyThemeBrightnessIndex) ?? 1];
    var colorIndex =
        StorageManager.sharedPreferences.getInt(keyThemeColorIndex) ?? 5;
    return [brightness, colorIndex];
  }
}
