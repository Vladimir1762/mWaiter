import 'dart:convert';

/// ID_CODE : 57162
/// TAPE_TYPE : 0
/// PreBillPrinted : 1
/// Discounts : 0
/// Bonuses : 0
/// Ready : 0
/// ID_CASHREGISTER : 7
/// ID_SHIFT : 4209
/// BILL_NUMBER : 52687
/// BILL_DATE : "2023-04-04T10:49:38"
/// OPEN_DATE : "2023-03-19T22:33:24"
/// AMOUNT : 1735.00
/// ID_WAITER : 62
/// NAME_WAITER : "Администратор ККМ"
/// TABLE_NUMBER : 2
/// GUESTS_COUNT : 3
/// NOTE : ""
/// ID_DOC_TYPE : 8
/// ID_FISCAL_TYPE : 0
/// FISCAL_NUMBER : 0
/// FLAGS : 1
/// ANN_ID : 0
/// ID_CARD : 0
/// PRINT_COUNT : 0
/// IS_READONLY : 0
/// PreBill_Number : 52687
/// ID_CASHIER : 62
/// Line : [{"ID_LINE":"362955","QUANTITY":"1.0000000e+000","DISP_NAME":"Котлетки по-домашнему жареные","PRICE":"465.00"},{"ID_LINE":"362956","QUANTITY":"1.0000000e+000","DISP_NAME":"Курица в соусе терияки","PRICE":"475.00"},{"ID_LINE":"362963","QUANTITY":"1.0000000e+000","DISP_NAME":"Шарик мороженого","PRICE":"125.00"},{"ID_LINE":"362964","QUANTITY":"1.0000000e+000","DISP_NAME":"Торт Прага","PRICE":"335.00"},{"ID_LINE":"362965","QUANTITY":"1.0000000e+000","DISP_NAME":"Чизкейк классический","PRICE":"335.00"}]

Bill billFromJson(String str) => Bill.fromJson(json.decode(str));

String billToJson(Bill data) => json.encode(data.toJson());

class Bill {
  Bill({
    num? idcode,
    num? tapetype,
    num? preBillPrinted,
    num? discounts,
    num? bonuses,
    num? ready,
    num? idcashregister,
    num? idshift,
    num? billnumber,
    String? billdate,
    String? opendate,
    num? amount,
    num? idwaiter,
    String? namewaiter,
    num? tablenumber,
    num? guestscount,
    String? note,
    num? iddoctype,
    num? idfiscaltype,
    num? fiscalnumber,
    num? flags,
    num? annid,
    num? idcard,
    num? printcount,
    num? isreadonly,
    num? preBillNumber,
    num? idcashier,
    num? iscurs2,
    num? iscurs3,
    num? iStatusBill,
    String? StatusBill,

    List<PreBillLine>? line,
  }) {
    _idcode = idcode;
    _tapetype = tapetype;
    _preBillPrinted = preBillPrinted;
    _discounts = discounts;
    _bonuses = bonuses;
    _ready = ready;
    _idcashregister = idcashregister;
    _idshift = idshift;
    _billnumber = billnumber;
    _billdate = billdate;
    _opendate = opendate;
    _amount = amount;
    _idwaiter = idwaiter;
    _namewaiter = namewaiter;
    _tablenumber = tablenumber;
    _guestscount = guestscount;
    _note = note;
    _iddoctype = iddoctype;
    _idfiscaltype = idfiscaltype;
    _fiscalnumber = fiscalnumber;
    _flags = flags;
    _annid = annid;
    _idcard = idcard;
    _printcount = printcount;
    _isreadonly = isreadonly;
    _preBillNumber = preBillNumber;
    _idcashier = idcashier;
    _iscurs2 = iscurs2;
    _iscurs3 = iscurs3;
    _iStatusBill = iStatusBill;
    _StatusBill = StatusBill;
    _line = line;
  }

  Bill.fromJson(dynamic json) {
    _idcode = json['ID_CODE'];
    _tapetype = json['TAPE_TYPE'];
    _preBillPrinted = json['PreBillPrinted'];
    _discounts = json['Discounts'];
    _bonuses = json['Bonuses'];
    _ready = json['Ready'];
    _idcashregister = json['ID_CASHREGISTER'];
    _idshift = json['ID_SHIFT'];
    _billnumber = json['BILL_NUMBER'];
    _billdate = json['BILL_DATE'];
    _opendate = json['OPEN_DATE'];
    _amount = json['AMOUNT'];
    _idwaiter = json['ID_WAITER'];
    _namewaiter = json['NAME_WAITER'];
    _tablenumber = json['TABLE_NUMBER'];
    _guestscount = json['GUESTS_COUNT'];
    _note = json['NOTE'];
    _iddoctype = json['ID_DOC_TYPE'];
    _idfiscaltype = json['ID_FISCAL_TYPE'];
    _fiscalnumber = json['FISCAL_NUMBER'];
    _flags = json['FLAGS'];
    _annid = json['ANN_ID'];
    _idcard = json['ID_CARD'];
    _printcount = json['PRINT_COUNT'];
    _isreadonly = json['IS_READONLY'];
    _preBillNumber = json['PreBill_Number'];
    _idcashier = json['ID_CASHIER'];
    _iscurs2 = json['IS_CURS2'];
    _iscurs3 = json['IS_CURS3'];
    _iStatusBill = json['iStatusBill'];
    _StatusBill = json['StatusBill'];
    if (json['Line'] != null) {
      _line = [];
      json['Line'].forEach((v) {
        _line?.add(PreBillLine.fromJson(v));
      });
    } else {
      _line = [];
    }
  }

  num? _idcode;
  num? _tapetype;
  num? _preBillPrinted;
  num? _discounts;
  num? _bonuses;
  num? _ready;
  num? _idcashregister;
  num? _idshift;
  num? _billnumber;
  String? _billdate;
  String? _opendate;
  num? _amount;
  num? _idwaiter;
  String? _namewaiter;
  num? _tablenumber;
  num? _guestscount;
  String? _note;
  num? _iddoctype;
  num? _idfiscaltype;
  num? _fiscalnumber;
  num? _flags;
  num? _annid;
  num? _idcard;
  num? _printcount;
  num? _isreadonly;
  num? _preBillNumber;
  num? _idcashier;
  num? _iscurs2;
  num? _iscurs3;
  num? _iStatusBill;
  String? _StatusBill;
  List<PreBillLine>? _line;

  Bill copyWith({
    num? idcode,
    num? tapetype,
    num? preBillPrinted,
    num? discounts,
    num? bonuses,
    num? ready,
    num? idcashregister,
    num? idshift,
    num? billnumber,
    String? billdate,
    String? opendate,
    num? amount,
    num? idwaiter,
    String? namewaiter,
    num? tablenumber,
    num? guestscount,
    String? note,
    num? iddoctype,
    num? idfiscaltype,
    num? fiscalnumber,
    num? flags,
    num? annid,
    num? idcard,
    num? printcount,
    num? isreadonly,
    num? preBillNumber,
    num? idcashier,
    num? iscurs2,
    num? iscurs3,
    num? iStatusBill,
    String? StatusBill,

    List<PreBillLine>? line,
  }) =>
      Bill(
        idcode: idcode ?? _idcode,
        tapetype: tapetype ?? _tapetype,
        preBillPrinted: preBillPrinted ?? _preBillPrinted,
        discounts: discounts ?? _discounts,
        bonuses: bonuses ?? _bonuses,
        ready: ready ?? _ready,
        idcashregister: idcashregister ?? _idcashregister,
        idshift: idshift ?? _idshift,
        billnumber: billnumber ?? _billnumber,
        billdate: billdate ?? _billdate,
        opendate: opendate ?? _opendate,
        amount: amount ?? _amount,
        idwaiter: idwaiter ?? _idwaiter,
        namewaiter: namewaiter ?? _namewaiter,
        tablenumber: tablenumber ?? _tablenumber,
        guestscount: guestscount ?? _guestscount,
        note: note ?? _note,
        iddoctype: iddoctype ?? _iddoctype,
        idfiscaltype: idfiscaltype ?? _idfiscaltype,
        fiscalnumber: fiscalnumber ?? _fiscalnumber,
        flags: flags ?? _flags,
        annid: annid ?? _annid,
        idcard: idcard ?? _idcard,
        printcount: printcount ?? _printcount,
        isreadonly: isreadonly ?? _isreadonly,
        preBillNumber: preBillNumber ?? _preBillNumber,
        idcashier: idcashier ?? _idcashier,
        iscurs2: iscurs2 ?? _iscurs2,
        iscurs3: iscurs3 ?? _iscurs3,
        iStatusBill:  iStatusBill ?? _iStatusBill,
        StatusBill:  StatusBill ?? _StatusBill,
        line: line ?? _line,
      );

  num? get idcode => _idcode;

  num? get tapetype => _tapetype;

  num? get preBillPrinted => _preBillPrinted;

  num? get discounts => _discounts;

  num? get bonuses => _bonuses;

  num? get ready => _ready;

  num? get idcashregister => _idcashregister;

  num? get idshift => _idshift;

  num? get billnumber => _billnumber;

  String? get billdate => _billdate;

  String? get opendate => _opendate;

  num? get amount => _amount;
  set amount(num? value) => _amount = value;

  num? get idwaiter => _idwaiter;

  String? get namewaiter => _namewaiter;

  num? get tablenumber => _tablenumber;

  num? get guestscount => _guestscount;

  set guestscount(num? value) => _guestscount = value;

  String? get note => _note;

  num? get iddoctype => _iddoctype;

  num? get idfiscaltype => _idfiscaltype;

  num? get fiscalnumber => _fiscalnumber;

  num? get flags => _flags;

  num? get annid => _annid;

  num? get idcard => _idcard;

  num? get printcount => _printcount;

  num? get isreadonly => _isreadonly;

  num? get preBillNumber => _preBillNumber;

  num? get idcashier => _idcashier;
  num? get iscurs2 => _iscurs2;
  num? get iscurs3 => _iscurs3;
  num? get iStatusBill => _iStatusBill;
  String? get StatusBill => _StatusBill;

  List<PreBillLine>? get line => _line;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = _idcode;
    map['TAPE_TYPE'] = _tapetype;
    map['PreBillPrinted'] = _preBillPrinted;
    map['Discounts'] = _discounts;
    map['Bonuses'] = _bonuses;
    map['Ready'] = _ready;
    map['ID_CASHREGISTER'] = _idcashregister;
    map['ID_SHIFT'] = _idshift;
    map['BILL_NUMBER'] = _billnumber;
    map['BILL_DATE'] = _billdate;
    map['OPEN_DATE'] = _opendate;
    map['AMOUNT'] = _amount;
    map['ID_WAITER'] = _idwaiter;
    map['NAME_WAITER'] = _namewaiter;
    map['TABLE_NUMBER'] = _tablenumber;
    map['GUESTS_COUNT'] = _guestscount;
    map['NOTE'] = _note;
    map['ID_DOC_TYPE'] = _iddoctype;
    map['ID_FISCAL_TYPE'] = _idfiscaltype;
    map['FISCAL_NUMBER'] = _fiscalnumber;
    map['FLAGS'] = _flags;
    map['ANN_ID'] = _annid;
    map['ID_CARD'] = _idcard;
    map['PRINT_COUNT'] = _printcount;
    map['IS_READONLY'] = _isreadonly;
    map['PreBill_Number'] = _preBillNumber;
    map['ID_CASHIER'] = _idcashier;
    map['IS_CURS2'] = _iscurs2;
    map['IS_CURS3'] = _iscurs3;
    map['iStatusBill'] = _iStatusBill;
    map['StatusBill'] = _StatusBill;
    if (_line != null) {
      map['Line'] = _line?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ID_LINE : "362955"
/// QUANTITY : "1.0000000e+000"
/// DISP_NAME : "Котлетки по-домашнему жареные"
/// PRICE : "465.00"

PreBillLine lineFromJson(String str) => PreBillLine.fromJson(json.decode(str));

String lineToJson(PreBillLine data) => json.encode(data.toJson());

class PreBillLine {
  PreBillLine({String? idline, String? quantity, String? dispname, String? price, String? norder}) {
    _idline = idline;
    _quantity = quantity;
    _dispname = dispname;
    _price = price;
    _norder = norder;
  }

  PreBillLine.fromJson(dynamic json) {
    _idline = json['ID_LINE'];
    _quantity = json['QUANTITY'];
    _dispname = json['DISP_NAME'];
    _price = json['PRICE'];
    _norder = json['N_ORDER'];
  }

  String? _idline;
  String? _quantity;
  String? _dispname;
  String? _price;
  String? _norder;

  PreBillLine copyWith({
    String? idline,
    String? quantity,
    String? dispname,
    String? price,
    String? norder,
  }) =>
      PreBillLine(
        idline: idline ?? _idline,
        quantity: quantity ?? _quantity,
        dispname: dispname ?? _dispname,
        price: price ?? _price,
        norder: norder ?? _norder,
      );

  String? get idline => _idline;

  String? get quantity => _quantity;
  set quantity(String? value) => _quantity = value;
  String? get dispname => _dispname;
  set dispname(String? value) => _dispname = value;
  String? get price => _price;

  String? get norder => _norder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_LINE'] = _idline;
    map['QUANTITY'] = _quantity;
    map['DISP_NAME'] = _dispname;
    map['PRICE'] = _price;
    map['N_ORDER'] = _norder;
    return map;
  }
}
