class Item {
  Item({
      this.idware, 
      this.dispname, 
      this.idcash, 
      this.idshop, 
      this.marking, 
      this.packing, 
      this.unitname, 
      this.price, 
      this.idmenu, 
      this.nodiscount, 
      this.maxdiscount,});

  Item.fromJson(dynamic json) {
    idware = json['ID_WARE'];
    dispname = json['DISP_NAME'];
    idcash = json['ID_CASH'];
    idshop = json['ID_SHOP'];
    marking = json['MARKING'];
    packing = json['PACKING'];
    unitname = json['UNIT_NAME'];
    price = json['PRICE'];
    idmenu = json['ID_MENU'];
    nodiscount = json['NO_DISCOUNT'];
    maxdiscount = json['MAX_DISCOUNT'];
  }
  int? idware;
  String? dispname;
  int? idcash;
  int? idshop;
  String? marking;
  String? packing;
  String? unitname;
  double? price;
  int? idmenu;
  int? nodiscount;
  double? maxdiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_WARE'] = idware;
    map['DISP_NAME'] = dispname;
    map['ID_CASH'] = idcash;
    map['ID_SHOP'] = idshop;
    map['MARKING'] = marking;
    map['PACKING'] = packing;
    map['UNIT_NAME'] = unitname;
    map['PRICE'] = price;
    map['ID_MENU'] = idmenu;
    map['NO_DISCOUNT'] = nodiscount;
    map['MAX_DISCOUNT'] = maxdiscount;
    return map;
  }

}