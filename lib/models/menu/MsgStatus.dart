import 'Msg.dart';

class MsgStatus {
  MsgStatus({
      this.msg,});

  MsgStatus.fromJson(dynamic json) {
    msg = json['Msg'] != null ? Msg.fromJson(json['Msg']) : null;
  }
  Msg? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (msg != null) {
      map['Msg'] = msg!.toJson();
    }
    return map;
  }

}