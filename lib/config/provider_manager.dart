import 'package:fun_android/view_model/favourite_model.dart';
import 'package:fun_android/view_model/locale_model.dart';
import 'package:provider/provider.dart';
import 'package:fun_android/view_model/theme_model.dart';
import 'package:fun_android/view_model/user_model.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
  ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
  ChangeNotifierProvider<GlobalFavouriteStateModel>.value(
      value: GlobalFavouriteStateModel())
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
List<SingleChildCloneableWidget> dependentServices = [
  ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
    builder: (context, globalFavouriteStateModel, userModel) =>
        userModel ?? UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
