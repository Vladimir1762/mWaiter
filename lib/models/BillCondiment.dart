class BillCondiment {
  BillCondiment({
      this.pkid, 
      this.idbill, 
      this.idline, 
      this.idcondiment, 
      this.idcode, 
      this.dispname, 
      this.vorder, 
      this.idfware, 
      this.idfgroup, 
      this.idware,});

  BillCondiment.fromJson(dynamic json) {
    pkid = json['PK_ID'];
    idbill = json['ID_BILL'];
    idline = json['ID_LINE'];
    idcondiment = json['ID_CONDIMENT'];
    idcode = json['ID_CODE'];
    dispname = json['DISP_NAME'];
    vorder = json['V_ORDER'];
    idfware = json['ID_FWARE'];
    idfgroup = json['ID_FGROUP'];
    idware = json['ID_WARE'];
  }
  int? pkid;
  int? idbill;
  int? idline;
  int? idcondiment;
  int? idcode;
  String? dispname;
  int? vorder;
  int? idfware;
  int? idfgroup;
  int? idware;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PK_ID'] = pkid;
    map['ID_BILL'] = idbill;
    map['ID_LINE'] = idline;
    map['ID_CONDIMENT'] = idcondiment;
    map['ID_CODE'] = idcode;
    map['DISP_NAME'] = dispname;
    map['V_ORDER'] = vorder;
    map['ID_FWARE'] = idfware;
    map['ID_FGROUP'] = idfgroup;
    map['ID_WARE'] = idware;
    return map;
  }

}