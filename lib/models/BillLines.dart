import 'Line.dart';

class BillLines {
  BillLines({
    this.line,
  });

  BillLines.fromJson(dynamic json) {
    if (json['Line'] != null) {
      line = [];
      json['Line'].forEach((v) {
        if (v != null){
        line!.add(Line.fromJson(v));}
      });
    } else {
      line = [];
    }
  }

  List<Line>? line;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (line != null) {
      map['Line'] = line!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
