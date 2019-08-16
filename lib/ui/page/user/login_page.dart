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
import 'package:wan_android/view_model/login_model.dart';
import 'package:wan_android/view_model/user_model.dart';

import 'package:wan_android/ui/page/user/login_widget.dart';

import 'login_field_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            LoginTopPanel(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoginLogo(),
                  LoginFormContainer(
                      child: ProviderWidget<LoginModel>(
                    model: LoginModel(Provider.of(context)),
                    onModelReady: (model) {
                      _nameController.text = model.getLoginName();
                    },
                    builder: (context, model, child) {
                      return Form(
                        onWillPop: () async {
                          return !model.busy;
                        },
                        child: child,
                      );
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          LoginTextField(
                            label: '用户名',
                            icon: Icons.person_outline,
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                          ),
                          LoginTextField(
                            controller: _passwordController,
                            label: '密码',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                          ),
                          LoginButton(_nameController, _passwordController),
                          SingUpWidget(_nameController),
                        ]),
                  )),
                  ThirdLogin()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.busy
          ? ButtonProgressIndicator()
          : Text(
              "登录",
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
                model
                    .login(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
                    Navigator.of(context).pop();
                  } else {
                    showToast(model.errorMessage);
                  }
                });
              }
            },
    );
  }
}

class SingUpWidget extends StatefulWidget {
  final nameController;

  SingUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        // 将注册成功的用户名,回填如登录框
        widget.nameController.text =
            await Navigator.of(context).pushNamed(RouteName.register);
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(text: '还没账号? ', children: [
        TextSpan(
            text: '去注册',
            recognizer: _recognizerRegister,
            style: TextStyle(color: Theme.of(context).primaryColor))
      ])),
    );
  }
}
