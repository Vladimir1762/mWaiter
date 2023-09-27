import 'Root.dart';

class GetBill {
  GetBill({
    this.root,
  });

  GetBill.fromJson(dynamic json) {
    root = json['Root'] != null ? Root.fromJson(json['Root']) : Root();
  }

  Root? root;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (root != null) {
      map['Root'] = root!.toJson();
    }
    return map;
  }

  double billSumm() {
    double result = 0;
    if (root!.billLines!.line != null) {
      root!.billLines!.line!.forEach((element) {
        if (element.idfline == 0) {
          result = result + element.price! * element.quantity!;
        }
      });
    }
    return result;
  }
}
