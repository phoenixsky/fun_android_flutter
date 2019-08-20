import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_android/generated/i18n.dart';
import 'package:fun_android/view_model/locale_model.dart';
import 'package:oktoast/oktoast.dart';
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
                            onChanged: (index) {
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
                        S.of(context).setting_language,
                        style: TextStyle(),
                      ),
                      Text(
                        LocaleModel.localeNameList[
                            Provider.of<LocaleModel>(context).localeIndex],
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
                        itemCount: LocaleModel.localeNameList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<LocaleModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchLocale(index);
                            },
                            groupValue: model.localeIndex,
                            title: Text(
                                LocaleModel.localeNameList[index]),
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
                  onTap: () {
                    showToast('请前往github,提issue');
                  },
                  leading: Icon(
                    Icons.feedback,
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
