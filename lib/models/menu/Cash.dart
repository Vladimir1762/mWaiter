class Cash {
  Cash({
      this.idcode, 
      this.dispname, 
      this.backcolor, 
      this.fontcolor, 
      this.weight,});

  Cash.fromJson(dynamic json) {
    idcode = json['ID_CODE'];
    dispname = json['DISP_NAME'];
    backcolor = json['BACK_COLOR'];
    fontcolor = json['FONT_COLOR'];
    weight = json['Weight'];
  }
  int? idcode;
  String? dispname;
  int? backcolor;
  int? fontcolor;
  int? weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = idcode;
    map['DISP_NAME'] = dispname;
    map['BACK_COLOR'] = backcolor;
    map['FONT_COLOR'] = fontcolor;
    map['Weight'] = weight;
    return map;
  }

}