class DiscountsWare {
  DiscountsWare({
      this.pkid, 
      this.idware, 
      this.idmenu, 
      this.iddiscount,});

  DiscountsWare.fromJson(dynamic json) {
    pkid = json['PKID'];
    idware = json['ID_WARE'];
    idmenu = json['ID_MENU'];
    iddiscount = json['ID_DISCOUNT'];
  }
  int? pkid;
  int? idware;
  int? idmenu;
  int? iddiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PKID'] = pkid;
    map['ID_WARE'] = idware;
    map['ID_MENU'] = idmenu;
    map['ID_DISCOUNT'] = iddiscount;
    return map;
  }

}