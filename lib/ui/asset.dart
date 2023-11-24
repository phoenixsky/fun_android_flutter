extension AssetExt on String {
  String get assetPNG => "assets/images/$this.png";
}

class Images {
  static String get splash => 'splash_bg'.assetPNG;

  static String get splashDark => 'splash_bg_dark'.assetPNG;

  static String get splashLogoFlutter => 'splash_logo_flutter'.assetPNG;

  static String get splashLogoFun => 'splash_logo_fun'.assetPNG;

  static String get splashLogoAndroid => 'splash_logo_android'.assetPNG;

  static String get splashLogoWan => 'splash_logo_wan'.assetPNG;
}
