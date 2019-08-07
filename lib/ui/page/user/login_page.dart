import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/config/router_config.dart';
import 'package:wan_android/ui/widget/bottom_clipper.dart';
import 'package:wan_android/ui/widget/button_progress_indicator.dart';
import 'package:wan_android/ui/widget/third_component.dart';
import 'package:wan_android/view_model/user_model.dart';

import 'package:wan_android/ui/page/user/login_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TapGestureRecognizer _recognizerRegister;

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer();
    _recognizerRegister.onTap = () {
      showToast('注册');
    };

    _nameController.text = '122086517@qq.com';
    _passwordController.text = 'forever21';

    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
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
                  LoginFormContainer(
                      child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          LoginTextField(
                            label: '用户名',
                            icon: Icons.person_outline,
                            controller: _nameController,
                          ),
                          LoginTextField(
                            controller: _passwordController,
                            label: '密码',
                            icon: Icons.lock_outline,
                            needObscure: true,
                          ),
                          LoginButtonWidget(
                              _nameController, _passwordController),
                          SingUpWidget(_recognizerRegister),
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

class SingUpWidget extends StatelessWidget {
  final TapGestureRecognizer _recognizerRegister;

  SingUpWidget(this._recognizerRegister);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(text: '还没账号? ', children: [
        TextSpan(
            text: '申请入驻',
            recognizer: _recognizerRegister,
            style: TextStyle(color: Theme.of(context).primaryColor))
      ])),
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  final TextEditingController _nameController;
  final TextEditingController _passwordController;

  LoginButtonWidget(this._nameController, this._passwordController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
      child: Consumer<UserModel>(
        builder: (context, userModel, child) {
          var color = Theme.of(context).primaryColor.withAlpha(180);
          return CupertinoButton(
            padding: EdgeInsets.all(0),
            color: color,
            disabledColor: color,
            borderRadius: BorderRadius.circular(110),
            pressedOpacity: 0.5,
            child: userModel.busy
                ? ButtonProgressIndicator()
                : Text(
                    "登录",
                    style: Theme.of(context)
                        .accentTextTheme
                        .title
                        .copyWith(letterSpacing: 10),
                  ),
            onPressed: userModel.busy
                ? null
                : () {
                    var formState = Form.of(context);
                    if (formState.validate()) {
                      formState.save();
                      userModel
                          .login(_nameController.text, _passwordController.text)
                          .then((value) {
                        if (value) {
//                          showToast(userModel.user.toString());
                          Navigator.of(context).pop();
//                          Navigator.of(context).pushReplacementNamed(RoutePaths.Tab);
                        } else {
                          showToast(userModel.errorMessage);
                        }
                      });
                    }
                  },
          );
        },
      ),
    );
  }
}
