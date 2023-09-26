import 'Condiment.dart';

class Condiments {
  Condiments({
      this.condiment,});

  Condiments.fromJson(dynamic json) {
    if (json['Condiment'] != null) {
      condiment = [];
      json['Condiment'].forEach((v) {
        condiment!.add(Condiment.fromJson(v));
      });
    }
  }
  List<Condiment>? condiment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (condiment != null) {
      map['Condiment'] = condiment!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}