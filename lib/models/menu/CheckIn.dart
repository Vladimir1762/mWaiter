import 'MsgStatus.dart';

class CheckIn {
  CheckIn({
      this.msgStatus,});

  CheckIn.fromJson(dynamic json) {
    msgStatus = json['MsgStatus'] != null ? MsgStatus.fromJson(json['MsgStatus']) : null;
  }
  MsgStatus? msgStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (msgStatus != null) {
      map['MsgStatus'] = msgStatus!.toJson();
    }
    return map;
  }

}