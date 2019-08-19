import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/view_model/theme_model.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('字体'),
                      Text(
                        ThemeModel.fontNameList[
                            Provider.of<ThemeModel>(context).fontIndex],
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: ThemeModel.fontValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<ThemeModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (value) {
                              model.switchFont(index);
                            },
                            groupValue: model.fontIndex,
                            title: Text(ThemeModel.fontNameList[index]),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '多语言',
                        style: TextStyle(),
                      ),
                      Text(
                        '跟随系统',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.language,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            value: 1,
                            onChanged: (value) {},
                            groupValue: 2,
                            title: Text('中文' + index.toString()),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text('意见反馈'),
                  onTap: () {},
                  leading: Icon(
                    Icons.alternate_email,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
