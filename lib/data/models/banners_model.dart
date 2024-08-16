
import 'dart:convert';

BannerData bannerDataFromJson(String str) => BannerData.fromJson(json.decode(str));

String bannerDataToJson(BannerData data) => json.encode(data.toJson());

class BannerData {
  int count;
  List<Banner> banner;
  BannerData({
    required this.count,
    required this.banner,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    count: json["count"],
    banner: List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
  };
}

class Banner {
  String id;
  String bannerImage;
  String createdAt;

  Banner({
    required this.id,
    required this.bannerImage,
    required this.createdAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    bannerImage: json["banner_image"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner_image": bannerImage,
    "created_at": createdAt,
  };
}
