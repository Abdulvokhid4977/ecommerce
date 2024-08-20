// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int status;
  String description;
  Data data;
  dynamic error;

  Product({
    required this.status,
    required this.description,
    required this.data,
    required this.error,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    status: json["status"],
    description: json["description"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "description": description,
    "data": data.toJson(),
    "error": error,
  };
}

class Data {
  int count;
  List<ProductElement> product;

  Data({
    required this.count,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: json["count"],
    product: List<ProductElement>.from(json["product"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class ProductElement {
  String id;
  String image;
  String name;
  String productCategoty;
  int price;
  int priceWithDiscount;
  int rating;
  int orderCount;
  String createdAt;
  bool? isFavourite;

  ProductElement({
    required this.id,
    required this.image,
    required this.name,
    required this.productCategoty,
    required this.price,
    required this.priceWithDiscount,
    required this.rating,
    required this.orderCount,
    required this.createdAt,
    this.isFavourite,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    productCategoty: json["product_categoty"],
    price: json["price"],
    priceWithDiscount: json["price_with_discount"],
    rating: json["rating"],
    orderCount: json["order_count"],
    createdAt: json["created_at"],
    isFavourite: json["is_favourite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "product_categoty": productCategoty,
    "price": price,
    "price_with_discount": priceWithDiscount,
    "rating": rating,
    "order_count": orderCount,
    "created_at": createdAt,
    "is_favourite": isFavourite,
  };
}
