// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Fun Android`
  String get appName {
    return Intl.message(
      'Fun Android',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get actionConfirm {
    return Intl.message(
      'Confirm',
      name: 'actionConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get actionCancel {
    return Intl.message(
      'Cancel',
      name: 'actionCancel',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed`
  String get viewStateMessageError {
    return Intl.message(
      'Load Failed',
      name: 'viewStateMessageError',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed,Check network `
  String get viewStateMessageNetworkError {
    return Intl.message(
      'Load Failed,Check network ',
      name: 'viewStateMessageNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Nothing Found`
  String get viewStateMessageEmpty {
    return Intl.message(
      'Nothing Found',
      name: 'viewStateMessageEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Not sign in yet`
  String get viewStateMessageUnAuth {
    return Intl.message(
      'Not sign in yet',
      name: 'viewStateMessageUnAuth',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get viewStateButtonRefresh {
    return Intl.message(
      'Refresh',
      name: 'viewStateButtonRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get viewStateButtonRetry {
    return Intl.message(
      'Retry',
      name: 'viewStateButtonRetry',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get viewStateButtonLogin {
    return Intl.message(
      'Sign In',
      name: 'viewStateButtonLogin',
      desc: '',
      args: [],
    );
  }

  /// `release to enter second floor`
  String get refreshTwoLevel {
    return Intl.message(
      'release to enter second floor',
      name: 'refreshTwoLevel',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get splashSkip {
    return Intl.message(
      'Skip',
      name: 'splashSkip',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tabHome {
    return Intl.message(
      'Home',
      name: 'tabHome',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get tabProject {
    return Intl.message(
      'Project',
      name: 'tabProject',
      desc: '',
      args: [],
    );
  }

  /// `Structure`
  String get tabStructure {
    return Intl.message(
      'Structure',
      name: 'tabStructure',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get tabUser {
    return Intl.message(
      'Me',
      name: 'tabUser',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingLanguage {
    return Intl.message(
      'Language',
      name: 'settingLanguage',
      desc: '',
      args: [],
    );
  }

  /// `System Font`
  String get settingFont {
    return Intl.message(
      'System Font',
      name: 'settingFont',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get logout {
    return Intl.message(
      'Sign Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favourites {
    return Intl.message(
      'Favorites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get feedback {
    return Intl.message(
      'FeedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Can't find mail app,please github issues`
  String get githubIssue {
    return Intl.message(
      'Can\'t find mail app,please github issues',
      name: 'githubIssue',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get autoBySystem {
    return Intl.message(
      'Auto',
      name: 'autoBySystem',
      desc: '',
      args: [],
    );
  }

  /// `ZCOOL KuaiLe`
  String get fontKuaiLe {
    return Intl.message(
      'ZCOOL KuaiLe',
      name: 'fontKuaiLe',
      desc: '',
      args: [],
    );
  }

  /// `not empty`
  String get fieldNotNull {
    return Intl.message(
      'not empty',
      name: 'fieldNotNull',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get toSignUp {
    return Intl.message(
      'Sign Up',
      name: 'toSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get rePassword {
    return Intl.message(
      'Confirm Password',
      name: 'rePassword',
      desc: '',
      args: [],
    );
  }

  /// `The two passwords differ`
  String get twoPwdDifferent {
    return Intl.message(
      'The two passwords differ',
      name: 'twoPwdDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get toSignIn {
    return Intl.message(
      'Sign In',
      name: 'toSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `No Account ? `
  String get noAccount {
    return Intl.message(
      'No Account ? ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `My favourites`
  String get myFavourites {
    return Intl.message(
      'My favourites',
      name: 'myFavourites',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get signIn3thd {
    return Intl.message(
      'More',
      name: 'signIn3thd',
      desc: '',
      args: [],
    );
  }

  /// `Hot`
  String get searchHot {
    return Intl.message(
      'Hot',
      name: 'searchHot',
      desc: '',
      args: [],
    );
  }

  /// `Shake`
  String get searchShake {
    return Intl.message(
      'Shake',
      name: 'searchShake',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get searchHistory {
    return Intl.message(
      'History',
      name: 'searchHistory',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `UnLike`
  String get unLike {
    return Intl.message(
      'UnLike',
      name: 'unLike',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get Like {
    return Intl.message(
      'Like',
      name: 'Like',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Wechat`
  String get wechatAccount {
    return Intl.message(
      'Wechat',
      name: 'wechatAccount',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Go to Sign In`
  String get needLogin {
    return Intl.message(
      'Go to Sign In',
      name: 'needLogin',
      desc: '',
      args: [],
    );
  }

  /// `Load failed,retry later`
  String get loadFailed {
    return Intl.message(
      'Load failed,retry later',
      name: 'loadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get collectionRemove {
    return Intl.message(
      'Remove',
      name: 'collectionRemove',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get article_tag_top {
    return Intl.message(
      'Top',
      name: 'article_tag_top',
      desc: '',
      args: [],
    );
  }

  /// `Open Browser`
  String get openBrowser {
    return Intl.message(
      'Open Browser',
      name: 'openBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Coin`
  String get coin {
    return Intl.message(
      'Coin',
      name: 'coin',
      desc: '',
      args: [],
    );
  }

  /// `Check Update`
  String get appUpdateCheckUpdate {
    return Intl.message(
      'Check Update',
      name: 'appUpdateCheckUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get appUpdateActionUpdate {
    return Intl.message(
      'Update',
      name: 'appUpdateActionUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Least version now `
  String get appUpdateLeastVersion {
    return Intl.message(
      'Least version now ',
      name: 'appUpdateLeastVersion',
      desc: '',
      args: [],
    );
  }

  /// `Downloading...`
  String get appUpdateDownloading {
    return Intl.message(
      'Downloading...',
      name: 'appUpdateDownloading',
      desc: '',
      args: [],
    );
  }

  /// `Download failed`
  String get appUpdateDownloadFailed {
    return Intl.message(
      'Download failed',
      name: 'appUpdateDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `It has been detected that it has been downloaded, whether it is installed?`
  String get appUpdateReDownloadContent {
    return Intl.message(
      'It has been detected that it has been downloaded, whether it is installed?',
      name: 'appUpdateReDownloadContent',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get appUpdateActionDownloadAgain {
    return Intl.message(
      'Download',
      name: 'appUpdateActionDownloadAgain',
      desc: '',
      args: [],
    );
  }

  /// `Install`
  String get appUpdateActionInstallApk {
    return Intl.message(
      'Install',
      name: 'appUpdateActionInstallApk',
      desc: '',
      args: [],
    );
  }

  /// `Version Update`
  String get appUpdateUpdate {
    return Intl.message(
      'Version Update',
      name: 'appUpdateUpdate',
      desc: '',
      args: [],
    );
  }

  /// `New version {version}`
  String appUpdateFoundNewVersion(Object version) {
    return Intl.message(
      'New version $version',
      name: 'appUpdateFoundNewVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Download canceled`
  String get appUpdateDownloadCanceled {
    return Intl.message(
      'Download canceled',
      name: 'appUpdateDownloadCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Press back again, cancel download`
  String get appUpdateDoubleBackTips {
    return Intl.message(
      'Press back again, cancel download',
      name: 'appUpdateDoubleBackTips',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}