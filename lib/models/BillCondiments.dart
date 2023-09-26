import 'BillCondiment.dart';

class BillCondiments {
  BillCondiments({
    this.condiment,
  });

  BillCondiments.fromJson(dynamic json) {
    if (json['Condiment'] != null) {
      condiment = [];
      json['Condiment'].forEach((v) {
        if (v != null){
        condiment!.add(BillCondiment.fromJson(v));}
      });
    } else {
      condiment = [];
    }
  }

  List<BillCondiment>? condiment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (condiment != null) {
      map['Condiment'] = condiment!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
