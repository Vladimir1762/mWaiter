import 'FeaturedRoot.dart';

class Fea {
  Fea({
      this.featuredRoot,});

  Fea.fromJson(dynamic json) {
    featuredRoot = json['FeaturedRoot'] != null ? FeaturedRoot.fromJson(json['FeaturedRoot']) : FeaturedRoot();
  }
  FeaturedRoot? featuredRoot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (featuredRoot != null) {
      map['FeaturedRoot'] = featuredRoot!.toJson();
    }
    return map;
  }

}