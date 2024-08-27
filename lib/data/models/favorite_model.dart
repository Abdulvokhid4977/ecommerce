// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
  int total;
  List<FavoriteElement> favorite;

  Favorite({
    required this.total,
    required this.favorite,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    total: json["total"],
    favorite: List<FavoriteElement>.from(json["favorite"].map((x) => FavoriteElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "favorite": List<dynamic>.from(favorite.map((x) => x.toJson())),
  };
}

class FavoriteElement {
  String productId;
  DateTime createdAt;

  FavoriteElement({
    required this.productId,
    required this.createdAt,
  });

  factory FavoriteElement.fromJson(Map<String, dynamic> json) => FavoriteElement(
    productId: json["product_id"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "created_at": createdAt.toIso8601String(),
  };
}
