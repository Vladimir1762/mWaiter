import 'Item.dart';

class FeaturedItems {
  FeaturedItems({
       this.item,});

  FeaturedItems.fromJson(dynamic json) {
    if (json['Item'] != null) {
      item = [];
      json['Item'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    } else { item = []; }
  }
  List<Item>? item = [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (item != null) {
      map['Item'] = item!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}