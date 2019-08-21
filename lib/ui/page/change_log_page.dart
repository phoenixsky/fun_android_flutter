import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fun_android/generated/i18n.dart';

class ChangeLogPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
      ),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: ChangeLogView(),
          ),
          Positioned(
            left: 30,
            right: 30,
            bottom: 8,
            child: CupertinoButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).close),
            ),
          )
        ]),
      ),
    );
  }
}

class ChangeLogView extends StatefulWidget {
  @override
  _ChangeLogViewState createState() => _ChangeLogViewState();
}

class _ChangeLogViewState extends State<ChangeLogView> {
  String _changelog;

  @override
  void initState() {
    rootBundle.loadString("CHANGELOG.md").then((data) {
      setState(() {
        _changelog = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_changelog == null) {
      return CircularProgressIndicator();
    }
    return Markdown(data: _changelog);
  }
}
