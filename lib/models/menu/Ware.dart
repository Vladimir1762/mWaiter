class Ware {
  Ware({
      this.idcode, 
      this.dispname, 
      this.idcash, 
      this.idshop, 
      this.marking, 
      this.packing, 
      this.rcena, 
      this.unitname, 
      this.assrId, 
      this.inStopList,});

  Ware.fromJson(dynamic json) {
    idcode = json['ID_CODE'];
    dispname = json['DISP_NAME'];
    idcash = json['ID_CASH'];
    idshop = json['ID_SHOP'];
    marking = json['MARKING'];
    packing = json['PACKING'];
    rcena = json['RCENA'];
    unitname = json['UNIT_NAME'];
    assrId = json['AssrId'];
    inStopList = json['in_StopList'];
  }
  int? idcode;
  String? dispname;
  int? idcash;
  int? idshop;
  String? marking;
  String? packing;
  double? rcena;
  String? unitname;
  int? assrId;
  int? inStopList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = idcode;
    map['DISP_NAME'] = dispname;
    map['ID_CASH'] = idcash;
    map['ID_SHOP'] = idshop;
    map['MARKING'] = marking;
    map['PACKING'] = packing;
    map['RCENA'] = rcena;
    map['UNIT_NAME'] = unitname;
    map['AssrId'] = assrId;
    map['in_StopList'] = inStopList;
    return map;
  }

}