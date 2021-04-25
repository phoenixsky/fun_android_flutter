import 'package:funflutter_wandroid/generated/json/base/json_convert_content.dart';

class BannerEntity with JsonConvert<BannerEntity> {
  late String desc;
  late int id;
  late String imagePath;
  late int isVisible;
  late int order;
  late String title;
  late int type;
  late String url;

  @override
  String toString() {
    return 'BannerEntity{desc: $desc, id: $id, imagePath: $imagePath, isVisible: $isVisible, order: $order, title: $title, type: $type, url: $url}';
  }
}