import 'Cash.dart';

class CashGroup {
  CashGroup({
      this.cash,});

  CashGroup.fromJson(dynamic json) {
    if (json['Cash'] != null) {
      cash = [];
      json['Cash'].forEach((v) {
        cash!.add(Cash.fromJson(v));
      });
    }
  }
  List<Cash>? cash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cash != null) {
      map['Cash'] = cash!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}