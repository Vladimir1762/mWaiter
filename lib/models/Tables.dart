class Tables {
  Tables({
       required this.tablenumber,
       required this.isused,});

  Tables.fromJson(dynamic json) {
    tablenumber = json['TABLE_NUMBER'];
    isused = json['IS_USED'];
  }
  int tablenumber = 0;
  int isused = 1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TABLE_NUMBER'] = tablenumber;
    map['IS_USED'] = isused;
    return map;
  }

}