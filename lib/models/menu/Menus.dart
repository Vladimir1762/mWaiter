import 'ServiceShop.dart';
import 'Condiments.dart';
import 'CashGroup.dart';
import 'Menu.dart';
import 'Wares.dart';
import 'DiscountsSets.dart';
import 'DiscountsWares.dart';
import 'MenuWorkTime.dart';

class Menus {
  Menus({
      this.serviceShop, 
      this.condiments, 
      this.cashGroup, 
      this.menu, 
      this.wares, 
      this.discountsSets, 
      this.discountsWares, 
      this.menuWorkTime,});

  Menus.fromJson(dynamic json) {
    serviceShop = json['ServiceShop'] != null ? ServiceShop.fromJson(json['ServiceShop']) : null;
    condiments = json['Condiments'] != null ? Condiments.fromJson(json['Condiments']) : null;
    cashGroup = json['CashGroup'] != null ? CashGroup.fromJson(json['CashGroup']) : null;
    menu = json['Menu'] != null ? Menu.fromJson(json['Menu']) : null;
    wares = json['Wares'] != null ? Wares.fromJson(json['Wares']) : null;
    discountsSets = json['Discounts_Sets'] != null ? DiscountsSets.fromJson(json['Discounts_Sets']) : null;
    discountsWares = json['Discounts_Wares'] != null ? DiscountsWares.fromJson(json['Discounts_Wares']) : null;
    menuWorkTime = json['MenuWorkTime'] != null ? MenuWorkTime.fromJson(json['MenuWorkTime']) : null;
  }
  ServiceShop? serviceShop;
  Condiments? condiments;
  CashGroup? cashGroup;
  Menu? menu;
  Wares? wares;
  DiscountsSets? discountsSets;
  DiscountsWares? discountsWares;
  MenuWorkTime? menuWorkTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (serviceShop != null) {
      map['ServiceShop'] = serviceShop!.toJson();
    }
    if (condiments != null) {
      map['Condiments'] = condiments!.toJson();
    }
    if (cashGroup != null) {
      map['CashGroup'] = cashGroup!.toJson();
    }
    if (menu != null) {
      map['Menu'] = menu!.toJson();
    }
    if (wares != null) {
      map['Wares'] = wares!.toJson();
    }
    if (discountsSets != null) {
      map['Discounts_Sets'] = discountsSets!.toJson();
    }
    if (discountsWares != null) {
      map['Discounts_Wares'] = discountsWares!.toJson();
    }
    if (menuWorkTime != null) {
      map['MenuWorkTime'] = menuWorkTime!.toJson();
    }
    return map;
  }

}