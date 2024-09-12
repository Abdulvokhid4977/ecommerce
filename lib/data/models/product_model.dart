// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int count;
  List<ProductElement> product;

  Product({
    required this.count,
    required this.product,
  });

  Product copyWith({
    int? count,
    List<ProductElement>? product,
  }) =>
      Product(
        count: count ?? this.count,
        product: product ?? this.product,
      );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      count: json["count"] ?? 0, // Provide a default value if count is null
      product: json["product"] != null
          ? List<ProductElement>.from(json["product"].map((x) => ProductElement.fromJson(x)))
          : [], // Return an empty list if product is null
    );
  }

  // factory Product.fromJson(Map<String, dynamic> json) => Product(
  //   count: json["count"],
  //   product: List<ProductElement>.from(json["product"].map((x) => ProductElement.fromJson(x))),
  // );
  //
  Map<String, dynamic> toJson() => {
    "count": count,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };

}

class ProductElement {
  String id;
  String categoryId;
  bool favorite;
  String name;
  int price;
  int withDiscount;
  int rating;
  String description;
  int orderCount;
  List<ProductColor> color;
  String createdAt;

  ProductElement({
    required this.id,
    required this.categoryId,
    required this.favorite,
    required this.name,
    required this.price,
    required this.withDiscount,
    required this.rating,
    required this.description,
    required this.orderCount,
    required this.color,
    required this.createdAt,
  });

  ProductElement copyWith({
    String? id,
    String? categoryId,
    bool? favorite,
    String? name,
    int? price,
    int? withDiscount,
    int? rating,
    String? description,
    int? orderCount,
    List<ProductColor>? color,
    String? createdAt,
  }) =>
      ProductElement(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        favorite: favorite ?? this.favorite,
        name: name ?? this.name,
        price: price ?? this.price,
        withDiscount: withDiscount ?? this.withDiscount,
        rating: rating ?? this.rating,
        description: description ?? this.description,
        orderCount: orderCount ?? this.orderCount,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    id: json["id"],
    categoryId: json["category_id"],
    favorite: json["favorite"],

    name: json["name"],
    price: json["price"],
    withDiscount: json["with_discount"],
    rating: json["rating"],
    description: json["description"],
    orderCount: json["order_count"],
    color: List<ProductColor>.from(json["color"].map((x) => ProductColor.fromJson(x))),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "favorite": favorite,
    "name": name,
    "price": price,
    "with_discount": withDiscount,
    "rating": rating,
    "description": description,
    "order_count": orderCount,
    "color": List<dynamic>.from(color.map((x) => x.toJson())),
    "created_at": createdAt,
  };
  List<String> getAllColorUrls() {
    return color.expand((element) => element.colorUrl).toList();
  }
}

class ProductColor {
  String id;
  String productId;
  String colorName;
  List<String> colorUrl;

  ProductColor({
    required this.id,
    required this.productId,
    required this.colorName,
    required this.colorUrl,
  });

  ProductColor copyWith({
    String? id,
    String? productId,
    String? colorName,
    List<String>? colorUrl,
  }) =>
      ProductColor(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        colorName: colorName ?? this.colorName,
        colorUrl: colorUrl ?? this.colorUrl,
      );

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
    id: json["id"],
    productId: json["product_id"],
    colorName: json["color_name"],
    colorUrl: List<String>.from(json["color_url"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "color_name": colorName,
    "color_url": List<dynamic>.from(colorUrl.map((x) => x)),
  };
}
