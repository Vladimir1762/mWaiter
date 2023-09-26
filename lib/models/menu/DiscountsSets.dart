import 'DiscountsSet.dart';

class DiscountsSets {
  DiscountsSets({
    this.discountsSet,});

  DiscountsSets.fromJson(dynamic json) {
    if (json['Discounts_Set'] != null) {
      discountsSet = [];
      json['Discounts_Set'].forEach((v) {
        discountsSet!.add(DiscountsSet.fromJson(v));
      });
    } else {
      discountsSet = [];
    }
  }

  List<DiscountsSet>? discountsSet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discountsSet != null) {
      map['Discounts_Set'] = discountsSet!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}