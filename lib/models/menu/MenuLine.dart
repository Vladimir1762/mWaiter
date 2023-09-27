class MenuLine {
  MenuLine({
      this.idmenu, 
      this.idline, 
      this.idchoice, 
      this.lineorder, 
      this.idware, 
      this.price, 
      this.quantity, 
      this.marking, 
      this.maxdiscount, 
      this.nodiscount, 
      this.weight,});

  MenuLine.fromJson(dynamic json) {
    idmenu = json['ID_MENU'];
    idline = json['ID_LINE'];
    idchoice = json['ID_CHOICE'];
    lineorder = json['LINE_ORDER'];
    idware = json['ID_WARE'];
    price = json['PRICE'];
    quantity = json['QUANTITY'];
    marking = json['MARKING'];
    maxdiscount = json['MAX_DISCOUNT'];
    nodiscount = json['NO_DISCOUNT'];
    weight = json['Weight'];
  }
  int? idmenu;
  int? idline;
  int? idchoice;
  int? lineorder;
  int? idware;
  double? price;
  double? quantity;
  String? marking;
  double? maxdiscount;
  int? nodiscount;
  int? weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_MENU'] = idmenu;
    map['ID_LINE'] = idline;
    map['ID_CHOICE'] = idchoice;
    map['LINE_ORDER'] = lineorder;
    map['ID_WARE'] = idware;
    map['PRICE'] = price;
    map['QUANTITY'] = quantity;
    map['MARKING'] = marking;
    map['MAX_DISCOUNT'] = maxdiscount;
    map['NO_DISCOUNT'] = nodiscount;
    map['Weight'] = weight;
    return map;
  }

}