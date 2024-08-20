// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int count;
  List<CategoryElement> category;

  Category({
    required this.count,
    required this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    count: json["count"],
    category: List<CategoryElement>.from(json["category"].map((x) => CategoryElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class CategoryElement {
  String id;
  String name;
  String url;
  String createdAt;

  CategoryElement({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "created_at": createdAt,
  };
}
