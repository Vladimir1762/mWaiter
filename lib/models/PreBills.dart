import 'Bill.dart';
/// PreBills : {"Bill":[{"ID_CODE":57161,"TAPE_TYPE":1,"PreBillPrinted":1,"Discounts":0,"Bonuses":0,"Ready":0,"ID_CASHREGISTER":7,"ID_SHIFT":4209,"BILL_NUMBER":0,"BILL_DATE":"2023-03-19T22:34:28","OPEN_DATE":"2023-03-19T22:33:24","AMOUNT":940.00,"ID_WAITER":597,"TABLE_NUMBER":2,"GUESTS_COUNT":3,"NOTE":"","ID_DOC_TYPE":8,"ID_FISCAL_TYPE":0,"FISCAL_NUMBER":0,"FLAGS":3,"ANN_ID":0,"ID_CARD":0,"PRINT_COUNT":1,"IS_READONLY":0,"PreBill_Number":52686,"ID_CASHIER":62,"DOC_TYPE_NAME":"Предварительный счет"},{"ID_CODE":57162,"TAPE_TYPE":1,"PreBillPrinted":0,"Discounts":0,"Bonuses":0,"Ready":2,"ID_CASHREGISTER":7,"ID_SHIFT":4209,"BILL_NUMBER":52687,"BILL_DATE":"2023-03-19T22:35:35","OPEN_DATE":"2023-03-19T22:33:24","AMOUNT":940.00,"ID_WAITER":62,"TABLE_NUMBER":2,"GUESTS_COUNT":3,"NOTE":"","ID_DOC_TYPE":8,"ID_FISCAL_TYPE":0,"FISCAL_NUMBER":0,"FLAGS":1,"ANN_ID":0,"ID_CARD":0,"PRINT_COUNT":0,"IS_READONLY":0,"PreBill_Number":52687,"ID_CASHIER":62,"DOC_TYPE_NAME":"Предварительный счет"},{"ID_CODE":57163,"TAPE_TYPE":1,"PreBillPrinted":1,"Discounts":0,"Bonuses":0,"Ready":0,"ID_CASHREGISTER":7,"ID_SHIFT":4209,"BILL_NUMBER":0,"BILL_DATE":"2023-03-19T22:41:05","OPEN_DATE":"2023-03-19T22:40:28","AMOUNT":1690.00,"ID_WAITER":597,"TABLE_NUMBER":4,"GUESTS_COUNT":5,"NOTE":"","ID_DOC_TYPE":8,"ID_FISCAL_TYPE":0,"FISCAL_NUMBER":0,"FLAGS":3,"ANN_ID":0,"ID_CARD":0,"PRINT_COUNT":1,"IS_READONLY":0,"PreBill_Number":52688,"ID_CASHIER":62,"DOC_TYPE_NAME":"Предварительный счет"},{"ID_CODE":57164,"TAPE_TYPE":1,"PreBillPrinted":0,"Discounts":0,"Bonuses":0,"Ready":2,"ID_CASHREGISTER":7,"ID_SHIFT":4209,"BILL_NUMBER":52689,"BILL_DATE":"2023-03-19T22:41:46","OPEN_DATE":"2023-03-19T22:40:28","AMOUNT":1690.00,"ID_WAITER":62,"TABLE_NUMBER":4,"GUESTS_COUNT":5,"NOTE":"","ID_DOC_TYPE":8,"ID_FISCAL_TYPE":0,"FISCAL_NUMBER":0,"FLAGS":1,"ANN_ID":0,"ID_CARD":0,"PRINT_COUNT":0,"IS_READONLY":0,"PreBill_Number":52689,"ID_CASHIER":62,"DOC_TYPE_NAME":"Предварительный счет"},{"ID_CODE":57165,"TAPE_TYPE":1,"PreBillPrinted":0,"Discounts":0,"Bonuses":0,"Ready":0,"ID_CASHREGISTER":7,"ID_SHIFT":4209,"BILL_NUMBER":0,"BILL_DATE":"2023-03-31T16:07:01","OPEN_DATE":"2023-03-31T16:06:49","AMOUNT":380.00,"ID_WAITER":62,"TABLE_NUMBER":2,"GUESTS_COUNT":3,"NOTE":"","ID_DOC_TYPE":8,"ID_FISCAL_TYPE":0,"FISCAL_NUMBER":0,"FLAGS":1,"ANN_ID":0,"ID_CARD":0,"PRINT_COUNT":0,"IS_READONLY":0,"PreBill_Number":52690,"ID_CASHIER":62,"DOC_TYPE_NAME":"Предварительный счет"}]}

class preBillList {
  preBillList({
    this.preBills,
  });

  PreBills? preBills;

  factory preBillList.fromJson(Map<String, dynamic> json) => preBillList(
    preBills: json["PreBills"] != null ? PreBills.fromJson(json["PreBills"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "PreBills": preBills!.toJson(),
  };
}

class PreBills {
  PreBills({
    this.bill,
  });

  List<Bill?>? bill;

  factory PreBills.fromJson(Map<String, dynamic> json) => PreBills(
    bill: json["Bill"] != null ? List<Bill?>.from(json["Bill"].map((x) => x == null ? null : Bill.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "Bill": List<dynamic>.from(bill!.map((x) => x?.toJson())),
  };
}
