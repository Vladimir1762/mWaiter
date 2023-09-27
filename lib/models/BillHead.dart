import 'Head.dart';

class BillHead {
  BillHead({
      this.head,});

  BillHead.fromJson(dynamic json) {
    head = json['Head'] != null ? Head.fromJson(json['Head']) : Head();
  }
  Head? head;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (head != null) {
      map['Head'] = head!.toJson();
    }
    return map;
  }

}