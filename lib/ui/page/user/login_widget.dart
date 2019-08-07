import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/config/resource_mananger.dart';
import 'package:wan_android/view_model/theme_model.dart';

class LoginTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool needObscure;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;

  LoginTextField(
      {this.label,
      this.icon,
      @required this.controller,
      this.needObscure: false,
      this.onSaved})
      : assert(controller != null);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isObscure;
  bool showDel = true;

  @override
  void initState() {
    isObscure = widget.needObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscure,
        validator: (value) {
          return value.trim().length > 0 ? null : '不能为空';
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
          suffixIcon: suffixIcon(theme),
        ).applyDefaults(theme.inputDecorationTheme),
      ),
    );
  }

  Widget suffixIcon(ThemeData theme) {
    return Builder(builder: (context) {
      widget.controller.addListener(() {
        if (mounted) {
          setState(() {
            showDel = widget.controller.text.length != 0;
          });
        }
      });
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Offstage(
            offstage: !widget.needObscure,
            child: InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  CupertinoIcons.eye,
                  size: 30,
                  color: isObscure ? theme.hintColor : theme.primaryColor,
                )),
          ),
          Offstage(
            offstage: !showDel,
            child: InkWell(
                onTap: () {
                  widget.controller.clear();
                },
                child: Icon(CupertinoIcons.clear,
                    size: 30, color: theme.hintColor)),
//                icon: Icon(Icons.close, color: theme.hintColor)),
          ),
        ],
      );
    });
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
      builder: (context,themeModel,child){
        return InkWell(
          onTap: (){
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
        color: theme.brightness == Brightness.dark ? theme.accentColor : Colors.white,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}


