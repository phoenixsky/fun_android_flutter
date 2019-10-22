import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier,S> extends StatefulWidget {
  final ValueWidgetBuilder<S> builder;
  final S Function(BuildContext, T) selector;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.selector,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _ProviderWidgetState<T,S> createState() => _ProviderWidgetState<T,S>();
}

class _ProviderWidgetState<T extends ChangeNotifier,S>
    extends State<ProviderWidget<T,S>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Selector<T,S>(
        selector: widget.selector,
        builder:widget.builder,
        child: widget.child,
      ),
    );
  }
}

