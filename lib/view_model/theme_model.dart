import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_android/ui/widget/theme.dart';
import 'package:wan_android/config/storage_manager.dart';

//const Color(0xFF5394FF),

class ThemeModel with ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeBrightnessIndex = 'kThemeBrightnessIndex';

  ThemeData _themeData;

  /// 当前主题颜色
  MaterialColor _color;

  ThemeModel() {
    var value = getThemeFromStorage();
    _themeData = _generateThemeData(value[0], value[1]);
  }

  ThemeData get value => _themeData;

  ThemeData get darkTheme => _themeData.copyWith(brightness: Brightness.dark);

  /// 切换指定色彩
  ///
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({Brightness brightness, MaterialColor color}) {
    color ??= _color;
    _themeData = _generateThemeData(brightness ?? _themeData.brightness, color);
    notifyListeners();

    saveTheme2Storage(brightness, color);
  }

  /// 随机一个主题色彩
  ///
  /// 可以指定明暗模式
  void switchRandomTheme({Brightness brightness}) {
    brightness ??= (Random().nextBool() ? Brightness.dark : Brightness.light);
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(brightness: brightness, color: Colors.primaries[colorIndex]);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  ThemeData _generateThemeData(
      Brightness brightness, MaterialColor themeColor) {
    _color = themeColor;
    var isDark = Brightness.dark == brightness;
    var themeData = ThemeData(
      brightness: brightness,

      /// 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle的颜色为白色,反之为黑色)
      primaryColorBrightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primarySwatch: themeColor,
//      accentColor: Colors.accents[colorIndex][400],
//      accentColor: isDark ? Colors.accents[colorIndex][700] : null,
      accentColor: isDark ? themeColor[700] : null,
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
  static saveTheme2Storage(
      Brightness brightness, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    await Future.wait([
      StorageManager.sharedPreferences
          .setInt(kThemeBrightnessIndex, brightness.index),
      StorageManager.sharedPreferences.setInt(kThemeColorIndex, index)
    ]);
  }

  /// 从shared preferences取出数据
  static getThemeFromStorage() {
    var brightness = Brightness.values[
        StorageManager.sharedPreferences.getInt(kThemeBrightnessIndex) ?? 0];
    var colorIndex =
        StorageManager.sharedPreferences.getInt(kThemeColorIndex) ?? 7;
    return [brightness, Colors.primaries[colorIndex]];
  }
}
