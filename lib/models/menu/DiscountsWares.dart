import 'DiscountsWare.dart';

class DiscountsWares {
  DiscountsWares({
    this.discountsWare,
  });

  DiscountsWares.fromJson(dynamic json) {
    if (json['Discounts_Ware'] != null) {
      discountsWare = [];
      json['Discounts_Ware'].forEach((v) {
        discountsWare!.add(DiscountsWare.fromJson(v));
      });
    } else {
      discountsWare = [];
    }
  }

  List<DiscountsWare>? discountsWare;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discountsWare != null) {
      map['Discounts_Ware'] = discountsWare!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
