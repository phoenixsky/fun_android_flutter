import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/config/resource_mananger.dart';
import 'package:wan_android/view_model/theme_model.dart';



//class LoginTextField extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}



class LoginTextField extends StatefulWidget {

  final String label;
  final String text;
  final IconData icon;
  final bool needObscure;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  LoginTextField(
      {this.label,
      this.icon,
      this.text,
      this.controller,
      this.needObscure: false,
      this.validator,
      this.onSaved});

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  TextEditingController controller;

  /// 显示清空按钮
  ValueNotifier<bool> hideDelNotifier;

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;


  @override
  void initState() {
//    validator = widget.validator ?? (_) => null;
    controller = controller ?? TextEditingController();
    controller.text = widget.text;
    hideDelNotifier = ValueNotifier(controller.text.isEmpty);
    controller.addListener(() {
      hideDelNotifier.value = controller.text.isEmpty;
    });
    obscureNotifier = ValueNotifier(widget.needObscure);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier,
        builder: (context, obscureText, child) => TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            var validator = widget.validator ?? (_) => null;
            return value.trim().length > 0 ? validator(value) : '不能为空';
          },
          onSaved: widget.onSaved,
//        textInputAction:
//            widget.needObscure ? TextInputAction.send : TextInputAction.next,
          decoration: InputDecoration(
//          contentPadding: EdgeInsets.all(1),
            prefixIcon: Icon(
              widget.icon,
              color: theme.accentColor,
              size: 20,
            ),
            hintText: widget.label,
            hintStyle: TextStyle(fontSize: 14),
            suffixIcon: suffixIcon(theme, obscureText),
          ).applyDefaults(theme.inputDecorationTheme),
        ),
      ),
    );
  }

  Widget suffixIcon(ThemeData theme, bool obscureText) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Offstage(
          offstage: !widget.needObscure,
          child: InkWell(
              onTap: () {
                obscureNotifier.value = !obscureNotifier.value;
              },
              child: Icon(
                CupertinoIcons.eye,
                size: 30,
                color: obscureText ? theme.hintColor : theme.primaryColor,
              )),
        ),
        ValueListenableBuilder(
          valueListenable: hideDelNotifier,
          builder: (context, bool value, child) {
            return Offstage(
              offstage: value,
              child: child,
            );
          },
          child: InkWell(
              onTap: () {
                controller.clear();
              },
              child:
                  Icon(CupertinoIcons.clear, size: 30, color: theme.hintColor)),
        ),
      ],
    );
  }
}

class LoginFormContainer extends StatelessWidget {
  final Widget child;

  LoginFormContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: Theme.of(context).cardColor,
          shadows: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(20),
                offset: Offset(1.0, 1.0),
                blurRadius: 10.0,
                spreadRadius: 3.0),
          ]),
      child: child,
    );
  }
}

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return InkWell(
          onTap: () {
            themeModel.switchRandomTheme();
          },
          child: child,
        );
      },
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: theme.brightness == Brightness.dark
            ? theme.accentColor
            : Colors.white,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}
