import 'Ware.dart';

class Wares {
  Wares({
      this.ware,});

  Wares.fromJson(dynamic json) {
    if (json['Ware'] != null) {
      ware = [];
      json['Ware'].forEach((v) {
        ware!.add(Ware.fromJson(v));
      });
    }
  }
  List<Ware>? ware;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ware != null) {
      map['Ware'] = ware!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}