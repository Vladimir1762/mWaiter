import 'Hall.dart';

class HallTable {
  HallTable({
      required this.hall,});

  HallTable.fromJson(dynamic json) {
    hall = json['Hall'] != null ? Hall.fromJson(json['Hall']) : null;
  }
  Hall? hall;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hall != null) {
      map['Hall'] = hall!.toJson();
    }
    return map;
  }

}