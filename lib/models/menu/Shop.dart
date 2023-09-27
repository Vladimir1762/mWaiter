class Shop {
  Shop({
      this.idcode, 
      this.dispname, 
      this.weight,});

  Shop.fromJson(dynamic json) {
    idcode = json['ID_CODE'];
    dispname = json['DISP_NAME'];
    weight = json['Weight'];
  }
  int? idcode;
  String? dispname;
  int? weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = idcode;
    map['DISP_NAME'] = dispname;
    map['Weight'] = weight;
    return map;
  }

}