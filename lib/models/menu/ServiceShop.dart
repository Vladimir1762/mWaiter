import 'Shop.dart';

class ServiceShop {
  ServiceShop({
      this.shop,});

  ServiceShop.fromJson(dynamic json) {
    if (json['Shop'] != null) {
      shop = [];
      json['Shop'].forEach((v) {
        shop!.add(Shop.fromJson(v));
      });
    }
  }
  List<Shop>? shop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shop != null) {
      map['Shop'] = shop!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}