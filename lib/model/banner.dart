class Banner {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  Banner.fromJsonMap(Map<String, dynamic> map)
      : desc = map["desc"],
        id = map["id"],
        imagePath = map["imagePath"],
        isVisible = map["isVisible"],
        order = map["order"],
        title = map["title"],
        type = map["type"],
        url = map["url"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = desc;
    data['id'] = id;
    data['imagePath'] = imagePath;
    data['isVisible'] = isVisible;
    data['order'] = order;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
