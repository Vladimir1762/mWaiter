import 'MenuLine.dart';

class MenuHead {
  MenuHead({
      this.idcode, 
      this.dispname, 
      this.menudate, 
      this.summamenu, 
      this.idtype, 
      this.menuLine,
      this.color = 0,
  });

  MenuHead.fromJson(dynamic json) {
    idcode = json['ID_CODE'];
    dispname = json['DISP_NAME'];
    menudate = json['MENU_DATE'];
    summamenu = json['SUMMA_MENU'];
    idtype = json['ID_TYPE'];
    if (json['MenuLine'] != null) {
      menuLine = [];
      json['MenuLine'].forEach((v) {
        menuLine!.add(MenuLine.fromJson(v));
      });
    }
  }
  int? idcode;
  String? dispname;
  String? menudate;
  double? summamenu;
  String? idtype;
  List<MenuLine>? menuLine;
  int? color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = idcode;
    map['DISP_NAME'] = dispname;
    map['MENU_DATE'] = menudate;
    map['SUMMA_MENU'] = summamenu;
    map['ID_TYPE'] = idtype;
    if (menuLine != null) {
      map['MenuLine'] = menuLine!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}