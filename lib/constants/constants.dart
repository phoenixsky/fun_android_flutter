import 'package:date_format/date_format.dart';

/// 常量类


/// 当前时间
/// 2021-04-23 17:25:47.500348
DateTime get currentTime => DateTime.now();

/// 当前时间戳
/// 1609222955510
int get currentTimeStamp => currentTime.millisecondsSinceEpoch;


/// 汉字时间
String get formatTime => formatDate(currentTime, [yyyy, '年', mm, '月', dd,'日 ',HH, ':', nn, ':', ss]);