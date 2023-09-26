import 'CheckIn.dart';

class CheckinResult {
  CheckinResult({
      this.checkIn,});

  CheckinResult.fromJson(dynamic json) {
    checkIn = json['CheckIn'] != null ? CheckIn.fromJson(json['CheckIn']) : null;
  }
  CheckIn? checkIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (checkIn != null) {
      map['CheckIn'] = checkIn!.toJson();
    }
    return map;
  }

}