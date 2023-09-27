class Head {
  Head({
    this.idcode,
    this.tapetype,
    this.idcashregister,
    this.idshift,
    this.billnumber,
    this.billdate,
    this.opendate,
    this.amount,
    this.idwaiter,
    this.tablenumber,
    this.guestscount,
    this.note,
    this.billimage,
    this.iddoctype,
    this.idfiscaltype,
    this.fiscalnumber,
    this.flags,
    this.annid,
    this.idcard,
    this.printcount,
    this.isreadonly,
    this.preBillNumber,
    this.idcashier,
  });

  Head.fromJson(dynamic json) {
    idcode = json['ID_CODE'];
    tapetype = json['TAPE_TYPE'];
    idcashregister = json['ID_CASHREGISTER'];
    idshift = json['ID_SHIFT'];
    billnumber = json['BILL_NUMBER'];
    billdate = json['BILL_DATE'];
    opendate = json['OPEN_DATE'];
    amount = json['AMOUNT'];
    idwaiter = json['ID_WAITER'];
    tablenumber = json['TABLE_NUMBER'];
    guestscount = json['GUESTS_COUNT'];
    note = json['NOTE'];
    billimage = json['BILL_IMAGE'];
    iddoctype = json['ID_DOC_TYPE'];
    idfiscaltype = json['ID_FISCAL_TYPE'];
    fiscalnumber = json['FISCAL_NUMBER'];
    flags = json['FLAGS'];
    annid = json['ANN_ID'];
    idcard = json['ID_CARD'];
    printcount = json['PRINT_COUNT'];
    isreadonly = json['IS_READONLY'];
    preBillNumber = json['PreBill_Number'];
    idcashier = json['ID_CASHIER'];
  }

  int? idcode;
  int? tapetype;
  int? idcashregister;
  int? idshift;
  int? billnumber;
  String? billdate;
  String? opendate;
  double? amount;
  int? idwaiter;
  int? tablenumber;
  int? guestscount;
  String? note;
  String? billimage;
  int? iddoctype;
  int? idfiscaltype;
  int? fiscalnumber;
  int? flags;
  int? annid;
  int? idcard;
  int? printcount;
  int? isreadonly;
  int? preBillNumber;
  int? idcashier;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = idcode;
    map['TAPE_TYPE'] = tapetype;
    map['ID_CASHREGISTER'] = idcashregister;
    map['ID_SHIFT'] = idshift;
    map['BILL_NUMBER'] = billnumber;
    map['BILL_DATE'] = billdate;
    map['OPEN_DATE'] = opendate;
    map['AMOUNT'] = amount;
    map['ID_WAITER'] = idwaiter;
    map['TABLE_NUMBER'] = tablenumber;
    map['GUESTS_COUNT'] = guestscount;
    map['NOTE'] = note;
    map['BILL_IMAGE'] = billimage;
    map['ID_DOC_TYPE'] = iddoctype;
    map['ID_FISCAL_TYPE'] = idfiscaltype;
    map['FISCAL_NUMBER'] = fiscalnumber;
    map['FLAGS'] = flags;
    map['ANN_ID'] = annid;
    map['ID_CARD'] = idcard;
    map['PRINT_COUNT'] = printcount;
    map['IS_READONLY'] = isreadonly;
    map['PreBill_Number'] = preBillNumber;
    map['ID_CASHIER'] = idcashier;

    return map;
  }
}
