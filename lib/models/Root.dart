import 'MsgStatus.dart';
import 'BillHead.dart';
import 'BillLines.dart';
import 'BillCondiments.dart';

class Root {
  Root({
      this.msgStatus,
      this.billHead, 
      this.billLines, 
      this.billCondiments,});

  Root.fromJson(dynamic json) {
    msgStatus = json['MsgStatus'] != null ? MsgStatus.fromJson(json['MsgStatus']) : null;
    billHead = json['BillHead'] != null ? BillHead.fromJson(json['BillHead']) : BillHead();
    billLines = json['BillLines'] != null ? BillLines.fromJson(json['BillLines']) : BillLines();
    billCondiments = json['BillCondiments'] != null ? BillCondiments.fromJson(json['BillCondiments']) : BillCondiments();
  }
  MsgStatus? msgStatus;
  BillHead? billHead;
  BillLines? billLines;
  BillCondiments? billCondiments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (msgStatus != null) {
      map['MsgStatus'] = msgStatus!.toJson();
    }
    if (billHead != null) {
      map['BillHead'] = billHead!.toJson();
    }
    if (billLines != null) {
      map['BillLines'] = billLines!.toJson();
    }
    if (billCondiments != null) {
      map['BillCondiments'] = billCondiments!.toJson();
    }
    return map;
  }

}