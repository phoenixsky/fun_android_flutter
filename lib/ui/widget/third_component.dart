import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wan_android/config/resource_mananger.dart';
import 'package:wan_android/service/wan_android_repository.dart';

class ThirdLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: theme.hintColor.withAlpha(50),
              height: 0.6,
              width: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('第三方登录', style: TextStyle(color: theme.hintColor)),
            ),
            Container(
              color: theme.hintColor.withAlpha(50),
              height: 0.6,
              width: 60,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showToast('蓄势待发,敬请期待');
                },
                child: Image.asset(
                  ImageHelper.wrapAssets('logo_wechat.png'),
                  width: 40,
                  height: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showToast('蓄势待发,敬请期待');
                },
                child: Image.asset(
                  ImageHelper.wrapAssets('logo_weibo.png'),
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
