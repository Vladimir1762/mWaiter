import 'Tables.dart';

class Hall {
  Hall({
      required this.tables,});

  Hall.fromJson(dynamic json) {
    if (json['Tables'] != null) {
      tables = [];
      json['Tables'].forEach((v) {
        tables.add(Tables.fromJson(v));
      });
    }
  }
  List<Tables> tables = [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tables != null) {
      map['Tables'] = tables.map((v) => v.toJson()).toList();
    }
    return map;
  }

}