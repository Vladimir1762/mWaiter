import '../MsgStatus.dart';
import 'FeaturedItems.dart';

class FeaturedRoot {
  FeaturedRoot({
      this.msgStatus, 
      this.featuredItems,});

  FeaturedRoot.fromJson(dynamic json) {
    msgStatus = json['MsgStatus'] != null ? MsgStatus.fromJson(json['MsgStatus']) : null;
    featuredItems = json['FeaturedItems'] != null ? FeaturedItems.fromJson(json['FeaturedItems']) : FeaturedItems();
  }
  MsgStatus? msgStatus;
  FeaturedItems? featuredItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (msgStatus != null) {
      map['MsgStatus'] = msgStatus!.toJson();
    }
    if (featuredItems != null) {
      map['FeaturedItems'] = featuredItems!.toJson();
    }
    return map;
  }

}