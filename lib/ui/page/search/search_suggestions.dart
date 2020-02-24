import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:flutter/cupertino.dart';
import 'package:fun_android/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/config/resource_mananger.dart';
import 'package:fun_android/flutter/search.dart';
import 'package:fun_android/model/search.dart';
import 'package:fun_android/provider/view_state_list_model.dart';
import 'package:fun_android/view_model/search_model.dart';

class SearchSuggestions<T> extends StatelessWidget {
  final SearchDelegate<T> delegate;

  SearchSuggestions({@required this.delegate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconTheme(
                data: Theme.of(context)
                    .iconTheme
                    .copyWith(opacity: 0.6, size: 16),
                child: MultiProvider(
                  providers: [
                    Provider<TextStyle>.value(
                        value: Theme.of(context).textTheme.body1),
                    ProxyProvider<TextStyle, Color>(
                      update: (context, textStyle, _) =>
                          textStyle.color.withOpacity(0.5),
                    ),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SearchHotKeysWidget(delegate: delegate),
                      SearchHistoriesWidget(delegate: delegate),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchHotKeysWidget extends StatefulWidget {
  final SearchDelegate delegate;

  SearchHotKeysWidget({@required this.delegate, key}) : super(key: key);

  @override
  _SearchHotKeysWidgetState createState() => _SearchHotKeysWidgetState();
}

class _SearchHotKeysWidgetState extends State<SearchHotKeysWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<SearchHotKeyModel>(context,listen: false).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: null,
                child: Text(
                  S.of(context).searchHot,
                  style: Provider.of<TextStyle>(context),
                ),
              ),
              Consumer<SearchHotKeyModel>(
                builder: (context, model, _) {
                  return Visibility(
                      visible: !model.isBusy,
                      child: model.isIdle
                          ? FlatButton.icon(
                              textColor: Provider.of<Color>(context),
                              onPressed: model.shuffle,
                              icon: Icon(
                                Icons.autorenew,
                              ),
                              label: Text(
                                S.of(context).searchShake,
                              ))
                          : FlatButton.icon(
                              textColor: Provider.of<Color>(context),
                              onPressed: model.initData,
                              icon: Icon(Icons.refresh),
                              label: Text(S.of(context).retry)));
                },
              )
            ],
          ),
        ),
        SearchSuggestionStateWidget<SearchHotKeyModel, SearchHotKey>(
          builder: (context, item) => ActionChip(
            label: Text(item.name),
            onPressed: () {
              widget.delegate.query = item.name;
              widget.delegate.showResults(context);
            },
          ),
        ),
      ],
    );
  }
}

class SearchHistoriesWidget<T> extends StatefulWidget {
  final SearchDelegate<T> delegate;

  SearchHistoriesWidget({@required this.delegate, key}) : super(key: key);

  @override
  _SearchHistoriesWidgetState createState() => _SearchHistoriesWidgetState();
}

class _SearchHistoriesWidgetState extends State<SearchHistoriesWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<SearchHistoryModel>(context,listen: false).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: null,
                child: Text(
                  S.of(context).searchHistory,
                  style: Provider.of<TextStyle>(context),
                ),
              ),
              Consumer<SearchHistoryModel>(
                builder: (context, model, child) => Visibility(
                    visible: !model.isBusy && !model.isEmpty,
                    child: model.isIdle
                        ? FlatButton.icon(
                            textColor: Provider.of<Color>(context),
                            onPressed: model.clearHistory,
                            icon: Icon(Icons.clear),
                            label: Text(S.of(context).clear))
                        : FlatButton.icon(
                            textColor: Provider.of<Color>(context),
                            onPressed: model.initData,
                            icon: Icon(Icons.refresh),
                            label: Text(S.of(context).retry))),
              ),
            ],
          ),
        ),
        SearchSuggestionStateWidget<SearchHistoryModel, String>(
          builder: (context, item) => ActionChip(
            label: Text(item),
            onPressed: () {
              widget.delegate.query = item;
              widget.delegate.showResults(context);
            },
          ),
        ),
      ],
    );
  }
}

class SearchSuggestionStateWidget<T extends ViewStateListModel, E>
    extends StatelessWidget {
  final Widget Function(BuildContext context, E data) builder;

  SearchSuggestionStateWidget({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
        builder: (context, model, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: model.isIdle
                  ? Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      children: List.generate(model.list.length, (index) {
                        E item = model.list[index];
                        return builder(context, item);
                      }),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      alignment: Alignment.center,
                      child: Builder(builder: (context) {
                        if (model.isBusy) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (model.isError) {
                          return const Icon(
                            IconFonts.pageError,
                            size: 60,
                            color: Colors.grey,
                          );
                        } else if (model.isEmpty) {
                          return const Icon(
                            IconFonts.pageEmpty,
                            size: 70,
                            color: Colors.grey,
                          );
                        }
                        return SizedBox.shrink();
                      }),
                    ),
            ));
  }
}
