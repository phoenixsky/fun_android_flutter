// 资源类扩展方法
extension wrapAsset on String {
  // 图片URL
  String assetImgUrl() {
    return "asset/image/$this";
  }
}
