///
/// log工具类
/// 参考喷子哥 https://github.com/openjmu/OpenJMU/blob/master/lib/utils/log_utils.dart
///
import 'dart:developer' as _dev;

import 'package:logging/logging.dart';

const String _TAG = 'LOG';

void logInfo(dynamic message, {String tag = _TAG, StackTrace? stackTrace}) {
  _printLog(message, '$tag ❕', stackTrace, level: Level.CONFIG);
}

void logDebug(dynamic message, {String tag = _TAG, StackTrace? stackTrace}) {
  _printLog(message, '$tag 📣', stackTrace, level: Level.INFO);
}

void logWarning(dynamic message, {String tag = _TAG, StackTrace? stackTrace}) {
  _printLog(message, '$tag ⚠️', stackTrace, level: Level.WARNING);
}

void logError(dynamic message,
    {String tag = _TAG, StackTrace? stackTrace, bool withStackTrace = true}) {
  _printLog(message, '$tag ❌', stackTrace,
      isError: true, level: Level.SEVERE, withStackTrace: withStackTrace);
}

void logJson(dynamic message, {String tag = _TAG, StackTrace? stackTrace}) {
  _printLog(message, '$tag 💠', stackTrace);
}

void _printLog(dynamic message, String tag, StackTrace? stackTrace,
    {bool isError = false,
    Level level = Level.ALL,
    bool withStackTrace = true}) {
  final currentTime = DateTime.now();
  if (isError) {
    _dev.log(
      '$currentTime - An error occurred.',
      time: currentTime,
      name: tag,
      level: level.value,
      error: message,
      stackTrace:
          stackTrace ?? (isError && withStackTrace ? StackTrace.current : null),
    );
  } else {
    _dev.log(
      '$currentTime - $message',
      time: currentTime,
      name: tag,
      level: level.value,
      stackTrace:
          stackTrace ?? (isError && withStackTrace ? StackTrace.current : null),
    );
  }
}
