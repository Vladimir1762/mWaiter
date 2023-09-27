class DiscountsSet {
  DiscountsSet({
      this.id, 
      this.dispname, 
      this.discount, 
      this.hourbeg, 
      this.hourend, 
      this.weekdays, 
      this.flag, 
      this.happynum, 
      this.isaccum, 
      this.isnext,});

  DiscountsSet.fromJson(dynamic json) {
    id = json['ID'];
    dispname = json['DISP_NAME'];
    discount = json['DISCOUNT'];
    hourbeg = json['HOUR_BEG'];
    hourend = json['HOUR_END'];
    weekdays = json['WEEK_DAYS'];
    flag = json['FLAG'];
    happynum = json['HAPPY_NUM'];
    isaccum = json['IS_ACCUM'];
    isnext = json['IS_NEXT'];
  }
  int? id;
  String? dispname;
  double? discount;
  String? hourbeg;
  String? hourend;
  int? weekdays;
  int? flag;
  int? happynum;
  int? isaccum;
  int? isnext;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['DISP_NAME'] = dispname;
    map['DISCOUNT'] = discount;
    map['HOUR_BEG'] = hourbeg;
    map['HOUR_END'] = hourend;
    map['WEEK_DAYS'] = weekdays;
    map['FLAG'] = flag;
    map['HAPPY_NUM'] = happynum;
    map['IS_ACCUM'] = isaccum;
    map['IS_NEXT'] = isnext;
    return map;
  }

}