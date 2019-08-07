
class SearchHotKey {

  int id;
  String link;
  String name;
  int order;
  int visible;

	SearchHotKey.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		link = map["link"],
		name = map["name"],
		order = map["order"],
		visible = map["visible"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['link'] = link;
		data['name'] = name;
		data['order'] = order;
		data['visible'] = visible;
		return data;
	}
}
