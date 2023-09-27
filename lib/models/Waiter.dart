import 'dart:convert';
/// USER : {"ID_CODE":714,"LOGIN":"50069","USER_NAME":"Дмитрий ","ID_ROLE":3,"CARD":"50069","PRIORITY":0,"ROLE_NAME":"Официант","ID_CASHREGISTER":7,"ID_CASHREG_NUMBER":"63","ID_ERROR":0,"MSG_ERROR":1}

Waiter waiterFromJson(String str) => Waiter.fromJson(json.decode(str));
String waiterToJson(Waiter data) => json.encode(data.toJson());
class Waiter {
  Waiter({
      User? user,}){
    _user = user;
}

  Waiter.fromJson(dynamic json) {
    _user = json['USER'] != null ? User.fromJson(json['USER']) : null;
  }
  User? _user;
Waiter copyWith({  User? user,
}) => Waiter(  user: user ?? _user,
);
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['USER'] = _user?.toJson();
    }
    return map;
  }

}

/// ID_CODE : 714
/// LOGIN : "50069"
/// USER_NAME : "Дмитрий "
/// ID_ROLE : 3
/// CARD : "50069"
/// PRIORITY : 0
/// ROLE_NAME : "Официант"
/// ID_CASHREGISTER : 7
/// ID_CASHREG_NUMBER : "63"
/// ID_ERROR : 0
/// MSG_ERROR : ""

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      int? idcode,
      String? login, 
      String? username, 
      num? idrole, 
      String? card, 
      num? priority, 
      String? rolename, 
      num? idcashregister, 
      String? idcashregnumber, 
      num? iderror, 
      String? msgerror,}){
    _idcode = idcode;
    _login = login;
    _username = username;
    _idrole = idrole;
    _card = card;
    _priority = priority;
    _rolename = rolename;
    _idcashregister = idcashregister;
    _idcashregnumber = idcashregnumber;
    _iderror = iderror;
    _msgerror = msgerror;
}

  User.fromJson(dynamic json) {
    _idcode = json['ID_CODE'];
    _login = json['LOGIN'];
    _username = json['USER_NAME'];
    _idrole = json['ID_ROLE'];
    _card = json['CARD'];
    _priority = json['PRIORITY'];
    _rolename = json['ROLE_NAME'];
    _idcashregister = json['ID_CASHREGISTER'];
    _idcashregnumber = json['ID_CASHREG_NUMBER'];
    _iderror = json['ID_ERROR'];
    _msgerror = json['MSG_ERROR'];
  }
  int? _idcode;
  String? _login;
  String? _username;
  num? _idrole;
  String? _card;
  num? _priority;
  String? _rolename;
  num? _idcashregister;
  String? _idcashregnumber;
  num? _iderror;
  String? _msgerror;
User copyWith({  int? idcode,
  String? login,
  String? username,
  num? idrole,
  String? card,
  num? priority,
  String? rolename,
  num? idcashregister,
  String? idcashregnumber,
  num? iderror,
  String? msgerror,
}) => User(  idcode: idcode ?? _idcode,
  login: login ?? _login,
  username: username ?? _username,
  idrole: idrole ?? _idrole,
  card: card ?? _card,
  priority: priority ?? _priority,
  rolename: rolename ?? _rolename,
  idcashregister: idcashregister ?? _idcashregister,
  idcashregnumber: idcashregnumber ?? _idcashregnumber,
  iderror: iderror ?? _iderror,
  msgerror: msgerror ?? _msgerror,
);
  int? get idcode => _idcode;
  String? get login => _login;
  String? get username => _username;
  num? get idrole => _idrole;
  String? get card => _card;
  num? get priority => _priority;
  String? get rolename => _rolename;
  num? get idcashregister => _idcashregister;
  String? get idcashregnumber => _idcashregnumber;
  num? get iderror => _iderror;
  String? get msgerror => _msgerror;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID_CODE'] = _idcode;
    map['LOGIN'] = _login;
    map['USER_NAME'] = _username;
    map['ID_ROLE'] = _idrole;
    map['CARD'] = _card;
    map['PRIORITY'] = _priority;
    map['ROLE_NAME'] = _rolename;
    map['ID_CASHREGISTER'] = _idcashregister;
    map['ID_CASHREG_NUMBER'] = _idcashregnumber;
    map['ID_ERROR'] = _iderror;
    map['MSG_ERROR'] = _msgerror;
    return map;
  }

}

class Users{
  List<User> _empList = [];
  List<User> get emploeesList => _empList;
  Employees({List<User>? UsersList}){
    _empList = UsersList!;
  }
  Users.fromJson(List<dynamic>? json){
    if (json != null){
      json.forEach((element) {_empList.add(new User.fromJson(element));});
    }
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String,dynamic>> map = new List.empty();
    map = _empList.map((e) => e.toJson()).toList();
    return map;
  }
}

class Waiters{
  List<Waiter> _empList = [];
  List<Waiter> get emploeesList => _empList;
  Employees({List<Waiter>? WaitersList}){
    _empList = WaitersList!;
  }
  Waiters.fromJson(List<dynamic>? json){
    if (json != null){
      json.forEach((element) {_empList.add(new Waiter.fromJson(element));});
    }
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String,dynamic>> map = new List.empty();
    map = _empList.map((e) => e.toJson()).toList();
    return map;
  }
}