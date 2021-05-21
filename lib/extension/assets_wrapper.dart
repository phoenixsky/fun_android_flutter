// 资源类扩展方法

const String _assetImagePrefix = "assets/images/";
const String _assetAnimationPrefix = "assets/animations/";

/// 资源类扩展方法
extension wrapAsset on String {
  /// 图片url
  String get assetImg => _assetImagePrefix + this;

  /// 选中图片的url
  /// 必须满足xxx_selected.png
  String get assetImgSelected {
    var split = this.split(".");
    return "${_assetImagePrefix + split[0]}_selected.${split[1]}";
  }

  /// 动画
  String get assetAnim => _assetAnimationPrefix + this;
}
