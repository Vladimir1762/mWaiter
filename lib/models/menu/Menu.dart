import 'MenuHead.dart';

class Menu {
  Menu({
      this.menuHead,});

  Menu.fromJson(dynamic json) {
    if (json['MenuHead'] != null) {
      menuHead = [];
      json['MenuHead'].forEach((v) {
        menuHead!.add(MenuHead.fromJson(v));
      });
    }
  }
  List<MenuHead>? menuHead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (menuHead != null) {
      map['MenuHead'] = menuHead!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}