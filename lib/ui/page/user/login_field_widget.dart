import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/generated/l10n.dart';

/// 登录页面表单字段框封装类
class LoginTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  LoginTextField({
    this.label,
    this.icon,
    this.controller,
    this.obscureText: false,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  TextEditingController controller;

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    // 默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier,
        builder: (context, value, child) => TextFormField(
          controller: controller,
          obscureText: value,
          validator: (text) {
            var validator = widget.validator ?? (_) => null;
            return text.trim().length > 0
                ? validator(text)
                : S.of(context).fieldNotNull;
          },
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: theme.accentColor, size: 22),
            hintText: widget.label,
            hintStyle: TextStyle(fontSize: 16),
            suffixIcon: LoginTextFieldSuffixIcon(
              controller: controller,
              obscureText: widget.obscureText,
              obscureNotifier: obscureNotifier,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  LoginTextFieldSuffixIcon(
      {this.controller, this.obscureNotifier, this.obscureText});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
//              debugPrint('onTap');
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (context, value, child) => Icon(
                CupertinoIcons.eye,
                size: 30,
                color: value ? theme.hintColor : theme.accentColor,
              ),
            ),
          ),
        ),
        LoginTextFieldClearIcon(controller)
      ],
    );
  }
}

class LoginTextFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  LoginTextFieldClearIcon(this.controller);

  @override
  _LoginTextFieldClearIconState createState() =>
      _LoginTextFieldClearIconState();
}

class _LoginTextFieldClearIconState extends State<LoginTextFieldClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if(mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.clear();
            });
          },
          child: Icon(CupertinoIcons.clear,
              size: 30, color: Theme.of(context).hintColor)),
    );
  }
}
