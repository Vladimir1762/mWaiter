class Msg {
  Msg({
      this.idStatus, 
      this.msgError,});

  Msg.fromJson(dynamic json) {
    idStatus = json['IdStatus'];
    msgError = json['MsgError'];
  }
  int? idStatus;
  String? msgError;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IdStatus'] = idStatus;
    map['MsgError'] = msgError;
    return map;
  }

}