class MWorkTime {
  MWorkTime({
      this.id, 
      this.idmenu, 
      this.hourbeg, 
      this.hourend, 
      this.weekdays,});

  MWorkTime.fromJson(dynamic json) {
    id = json['ID'];
    idmenu = json['ID_MENU'];
    hourbeg = json['HOUR_BEG'];
    hourend = json['HOUR_END'];
    weekdays = json['WEEK_DAYS'];
  }
  int? id;
  int? idmenu;
  String? hourbeg;
  String? hourend;
  int? weekdays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['ID_MENU'] = idmenu;
    map['HOUR_BEG'] = hourbeg;
    map['HOUR_END'] = hourend;
    map['WEEK_DAYS'] = weekdays;
    return map;
  }

}