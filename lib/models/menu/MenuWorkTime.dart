import 'MWorkTime.dart';

class MenuWorkTime {
  MenuWorkTime({
      this.mWorkTime,});

  MenuWorkTime.fromJson(dynamic json) {
    if (json['MWorkTime'] != null) {
      mWorkTime = [];
      json['MWorkTime'].forEach((v) {
        mWorkTime!.add(MWorkTime.fromJson(v));
      });
    }
  }
  List<MWorkTime>? mWorkTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mWorkTime != null) {
      map['MWorkTime'] = mWorkTime!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}