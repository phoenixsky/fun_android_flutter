class SearchHotKey {
  int id;
  String link;
  String name;
  int order;
  int visible;

  static SearchHotKey fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
		SearchHotKey searchBean = SearchHotKey();
    searchBean.id = map['id'];
    searchBean.link = map['link'];
    searchBean.name = map['name'];
    searchBean.order = map['order'];
    searchBean.visible = map['visible'];
    return searchBean;
  }

  Map toJson() => {
    "id": id,
    "link": link,
    "name": name,
    "order": order,
    "visible": visible,
  };
}