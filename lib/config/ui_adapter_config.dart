import 'dart:async';
import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

const double SCREEN_WIDTH = 414;
//const double DESIGN_ASPECT_RATIO = 414/896;

/// Android  480  * 800  aspectRatio为0.6
/// Android  720  * 1280 aspectRatio为0.5625
/// Android  1080 * 1920 aspectRatio为0.5625
/// Android  1440 * 2560 aspectRatio为0.5625
/// iPhone6  750  x 1334 aspectRatio为0.5625
/// iPhone6P 1242 x 2208 aspectRatio为0.5625
/// iPhoneX  1125 x 2436 aspectRatio为0.5625
/// iPhoneXr 828  x 1792 aspectRatio为0.4621
/// iPhoneXM 1242 x 2688 aspectRatio为0.4621

double getAdapterWidth() {
  return SCREEN_WIDTH;
}

double getAdapterRatio() {
  return ui.window.physicalSize.width / getAdapterWidth();
}

double getAdapterRatioRatio() {
  return getAdapterRatio() / ui.window.devicePixelRatio;
}

Size getScreenAdapterSize() {
  return Size(getAdapterWidth(), ui.window.physicalSize.height / getAdapterRatio());
}

/// 见 https://github.com/genius158/FlutterTest
class InnerWidgetsFlutterBinding extends WidgetsFlutterBinding {
  static WidgetsBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) InnerWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    return ViewConfiguration(
      size: getScreenAdapterSize(),
      devicePixelRatio: getAdapterRatio(),
    );
  }

  ///
  /// 以下用于重写 GestureBinding
  /// 唯一目的 把 _handlePointerDataPacket 方法 事件原始数据转换 改用
  /// 修改过的 PixelRatio

  @override
  void initInstances() {
    super.initInstances();
    ui.window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(PointerEventConverter.expand(
        packet.data,
        // 适配事件的转换比率,采用我们修改的
        getAdapterRatio()));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked)
      scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty)
      _handlePointerEvent(_pendingPointerEvents.removeFirst());
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result != null) dispatchEvent(event, result);
  }
}
