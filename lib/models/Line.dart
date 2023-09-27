class Line {
  Line({
      this.idbill, 
      this.idware, 
      this.price, 
      this.quantity,
      this.group,
      this.taxraterow, 
      this.sumraterow, 
      this.taxrate, 
      this.sumrate, 
      this.markquantity,
      this.norder, 
      this.idline, 
      this.dispname, 
      this.idfline, 
      this.iscomplex, 
      this.complexquantity, 
      this.nodiscount, 
      this.originalid, 
      this.idmenu, 
      this.isServed, 
      this.gnumber, 
      this.packing, 
      this.unitname, 
      this.idshop, 
      this.marking,
      this.idchoice,
      this.idcomplexline,
      this.iscomplited,
  });

  Line.fromJson(dynamic json) {
    idbill = json['ID_BILL'];
    idware = json['ID_WARE'];
    price = json['PRICE'];
    quantity = json['QUANTITY'];
    taxraterow = json['TAX_RATE_ROW'];
    sumraterow = json['SUM_RATE_ROW'];
    taxrate = json['TAX_RATE'];
    sumrate = json['SUM_RATE'];
    markquantity = json['MARK_QUANTITY'];
    norder = json['N_ORDER'];
    idline = json['ID_LINE'];
    dispname = json['DISP_NAME'];
    idfline = json['ID_FLINE'];
    iscomplex = json['IS_COMPLEX'];
    complexquantity = json['COMPLEX_QUANTITY'];
    nodiscount = json['NO_DISCOUNT'];
    originalid = json['ORIGINAL_ID'];
    idmenu = json['ID_MENU'];
    isServed = json['IsServed'];
    gnumber = json['G_NUMBER'];
    packing = json['PACKING'];
    unitname = json['UNIT_NAME'];
    idshop = json['ID_SHOP'];
    marking = json['MARKING'];
    iscomplited = json['IS_COMPLETED'];
  }
  int? idbill;
  int? idware;
  double? price;
  double? quantity;
  int? group; //*** кассовые группы в меню
  double? taxraterow;
  double? sumraterow;
  double? taxrate;
  double? sumrate;
  double? markquantity = 0;
  int? norder;
  int? idline;
  String? dispname;
  int? idfline;
  int? iscomplex;
  double? complexquantity;
  int? nodiscount;
  int? originalid;
  int? idmenu;
  int? isServed;
  int? gnumber;
  String? packing;
  String? unitname;
  int? idshop;
  String? marking;
  int? idchoice;
  int? idcomplexline;
  int? iscomplited;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_BILL'] = idbill;
    map['ID_WARE'] = idware;
    map['PRICE'] = price;
    map['QUANTITY'] = quantity;
    map['TAX_RATE_ROW'] = taxraterow;
    map['SUM_RATE_ROW'] = sumraterow;
    map['TAX_RATE'] = taxrate;
    map['SUM_RATE'] = sumrate;
    map['MARK_QUANTITY'] = markquantity;
    map['N_ORDER'] = norder;
    map['ID_LINE'] = idline;
    map['DISP_NAME'] = dispname;
    map['ID_FLINE'] = idfline;
    map['IS_COMPLEX'] = iscomplex;
    map['COMPLEX_QUANTITY'] = complexquantity;
    map['NO_DISCOUNT'] = nodiscount;
    map['ORIGINAL_ID'] = originalid;
    map['ID_MENU'] = idmenu;
    map['IsServed'] = isServed;
    map['G_NUMBER'] = gnumber;
    map['PACKING'] = packing;
    map['UNIT_NAME'] = unitname;
    map['ID_SHOP'] = idshop;
    map['MARKING'] = marking;
    map['IS_COMPLETED'] = iscomplited;
    return map;
  }

}