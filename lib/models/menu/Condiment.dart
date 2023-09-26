class Condiment {
  Condiment({
    this.idcode,
    this.vorder,
    this.dispname,
    this.idfware,
    this.idfgroup,
    this.idware,
  });

  Condiment.fromJson(dynamic json) {
    idcode = json['ID_CODE'];
    vorder = json['V_ORDER'];
    dispname = json['DISP_NAME'];
    idfware = json['ID_FWARE'];
    idfgroup = json['ID_FGROUP'];
    idware = json['ID_WARE'];
  }

  int? idcode;
  int? vorder;
  String? dispname;
  int? idfware;
  int? idfgroup;
  int? idware;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = idcode;
    map['V_ORDER'] = vorder;
    map['DISP_NAME'] = dispname;
    map['ID_FWARE'] = idfware;
    map['ID_FGROUP'] = idfgroup;
    map['ID_WARE'] = idware;
    return map;
  }
}
