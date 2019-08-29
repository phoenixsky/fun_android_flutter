class CoinRecord {
  int coinCount;
  int date;
  String desc;
  int id;
  int type;
  int userId;
  String userName;

  static CoinRecord fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CoinRecord coinRecordBean = CoinRecord();
    coinRecordBean.coinCount = map['coinCount'];
    coinRecordBean.date = map['date'];
    coinRecordBean.desc = map['desc'];
    coinRecordBean.id = map['id'];
    coinRecordBean.type = map['type'];
    coinRecordBean.userId = map['userId'];
    coinRecordBean.userName = map['userName'];
    return coinRecordBean;
  }

  Map toJson() => {
        "coinCount": coinCount,
        "date": date,
        "desc": desc,
        "id": id,
        "type": type,
        "userId": userId,
        "userName": userName,
      };
}
