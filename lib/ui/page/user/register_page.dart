import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/provider/provider_widget.dart';
import 'package:wan_android/ui/widget/bottom_clipper.dart';
import 'package:wan_android/ui/widget/button_progress_indicator.dart';
import 'package:wan_android/ui/widget/third_component.dart';
import 'package:wan_android/view_model/register_model.dart';
import 'package:wan_android/view_model/user_model.dart';

import 'package:wan_android/ui/page/user/login_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.6,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoginLogo(),
                  Form(
                    child: ProviderWidget<RegisterModel>(
                        model: RegisterModel(),
                        builder: (context, model, child) => LoginFormContainer(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    LoginTextField(
                                      label: '用户名',
                                      icon: Icons.person_outline,
                                      text: '哈哈',
                                      onSaved: (value) =>
                                          model.loginName = value,
                                    ),
                                    LoginTextField(
                                      label: '密码',
                                      icon: Icons.lock_outline,
                                      needObscure: true,
                                      onSaved: (value) =>
                                          model.password = value,
                                    ),
                                    LoginTextField(
                                      label: '确认密码',
                                      icon: Icons.lock_outline,
                                      needObscure: true,
                                      validator: (value) =>
                                          value != model.password
                                              ? '两次密码不一致'
                                              : null,
                                      onSaved: (value) =>
                                          model.rePassword = value,
                                    ),
                                    RegisterButtonWidget(
                                      child: model.busy
                                          ? ButtonProgressIndicator
                                          : Text(
                                              "注册",
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .title
                                                  .copyWith(letterSpacing: 10),
                                            ),
                                      onPressed: model.busy
                                          ? null
                                          : () {
                                              var formState = Form.of(context);
                                              if (formState.validate()) {
                                                if (model.rePassword !=
                                                    model.password) {
                                                  showToast('两次密码不一致');
                                                  return;
                                                }
                                                formState.save();
                                                model.singUp().then((value) {});
                                              }
                                            },
                                    ),
                                  ]),
                            )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  RegisterButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(110),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}
