import 'Menus.dart';

class MenuStructure {
  MenuStructure({
      this.menus,});

  MenuStructure.fromJson(dynamic json) {
    menus = json['Menus'] != null ? Menus.fromJson(json['Menus']) : null;
  }
  Menus? menus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (menus != null) {
      map['Menus'] = menus!.toJson();
    }
    return map;
  }

}