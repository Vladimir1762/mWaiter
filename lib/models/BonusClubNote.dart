import 'dart:convert';
/// BonusClub : {"MsgStatus":{"Msg":{"IdStatus":-1,"MsgError":"Note обновлено."}}}

BonusClubNote bonusClubNoteFromJson(String str) => BonusClubNote.fromJson(json.decode(str));
String bonusClubNoteToJson(BonusClubNote data) => json.encode(data.toJson());
class BonusClubNote {
  BonusClubNote({
      BonusClub? bonusClub,}){
    _bonusClub = bonusClub;
}

  BonusClubNote.fromJson(dynamic json) {
    _bonusClub = json['BonusClub'] != null ? BonusClub.fromJson(json['BonusClub']) : null;
  }
  BonusClub? _bonusClub;
BonusClubNote copyWith({  BonusClub? bonusClub,
}) => BonusClubNote(  bonusClub: bonusClub ?? _bonusClub,
);
  BonusClub? get bonusClub => _bonusClub;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bonusClub != null) {
      map['BonusClub'] = _bonusClub?.toJson();
    }
    return map;
  }

}

/// MsgStatus : {"Msg":{"IdStatus":-1,"MsgError":"Note обновлено."}}

BonusClub bonusClubFromJson(String str) => BonusClub.fromJson(json.decode(str));
String bonusClubToJson(BonusClub data) => json.encode(data.toJson());
class BonusClub {
  BonusClub({
      MsgStatus? msgStatus,}){
    _msgStatus = msgStatus;
}

  BonusClub.fromJson(dynamic json) {
    _msgStatus = json['MsgStatus'] != null ? MsgStatus.fromJson(json['MsgStatus']) : null;
  }
  MsgStatus? _msgStatus;
BonusClub copyWith({  MsgStatus? msgStatus,
}) => BonusClub(  msgStatus: msgStatus ?? _msgStatus,
);
  MsgStatus? get msgStatus => _msgStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_msgStatus != null) {
      map['MsgStatus'] = _msgStatus?.toJson();
    }
    return map;
  }

}

/// Msg : {"IdStatus":-1,"MsgError":"Note обновлено."}

MsgStatus msgStatusFromJson(String str) => MsgStatus.fromJson(json.decode(str));
String msgStatusToJson(MsgStatus data) => json.encode(data.toJson());
class MsgStatus {
  MsgStatus({
      Msg? msg,}){
    _msg = msg;
}

  MsgStatus.fromJson(dynamic json) {
    _msg = json['Msg'] != null ? Msg.fromJson(json['Msg']) : null;
  }
  Msg? _msg;
MsgStatus copyWith({  Msg? msg,
}) => MsgStatus(  msg: msg ?? _msg,
);
  Msg? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_msg != null) {
      map['Msg'] = _msg?.toJson();
    }
    return map;
  }

}

/// IdStatus : -1
/// MsgError : "Note обновлено."

Msg msgFromJson(String str) => Msg.fromJson(json.decode(str));
String msgToJson(Msg data) => json.encode(data.toJson());
class Msg {
  Msg({
      int? idStatus, 
      String? msgError,}){
    _idStatus = idStatus;
    _msgError = msgError;
}

  Msg.fromJson(dynamic json) {
    _idStatus = json['IdStatus'];
    _msgError = json['MsgError'];
  }
  int? _idStatus;
  String? _msgError;
Msg copyWith({  int? idStatus,
  String? msgError,
}) => Msg(  idStatus: idStatus ?? _idStatus,
  msgError: msgError ?? _msgError,
);
  int? get idStatus => _idStatus;
  String? get msgError => _msgError;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IdStatus'] = _idStatus;
    map['MsgError'] = _msgError;
    return map;
  }

}