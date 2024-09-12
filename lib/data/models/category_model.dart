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

  Category copyWith({
    int? count,
    List<CategoryElement>? category,
  }) =>
      Category(
        count: count ?? this.count,
        category: category ?? this.category,
      );

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      count: json["count"] ?? 0,
      category: json["category"]!=null? List<CategoryElement>.from(
          json["category"].map((x) => CategoryElement.fromJson(x))): []
    );
  }

  Map<String, dynamic> toJson() => {
    "count": count,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class CategoryElement {
  String id;
  String name;
  String parentId;
  String url;
  String createdAt;
  String? updatedAt;
  String? deleteAt;

  CategoryElement({
    required this.id,
    required this.name,
    required this.parentId,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.deleteAt,
  });

  CategoryElement copyWith({
    String? id,
    String? name,
    String? parentId,
    String? url,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) =>
      CategoryElement(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId ?? this.parentId,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleteAt: deleteAt ?? this.deleteAt,
      );

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
    url: json["url"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deleteAt: json["delete_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
    "url": url,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "delete_at": deleteAt,
  };
}
