// 资源类扩展方法
extension wrapAsset on String {
  // 图片URL
  String get assetsImgUrl => "assets/images/$this";
  // 动画
  String get assetsAnimUrl => "assets/animations/$this";
}
