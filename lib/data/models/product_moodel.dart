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

  Product copyWith({
    int? status,
    String? description,
    Data? data,
    dynamic error,
  }) {
    return Product(
      status: status ?? this.status,
      description: description ?? this.description,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
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
        product: List<ProductElement>.from(
            json["product"].map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };

  Data copyWith({
    int? count,
    List<ProductElement>? product,
  }) {
    return Data(
      count: count ?? this.count,
      product: product ?? this.product,
    );
  }
}

class ProductElement {
  String id;
  String image;
  String name;
  String productCategory;
  int price;
  int priceWithDiscount;
  double rating;
  int orderCount;
  String createdAt;
  String description;
  bool? isFavourite;

  ProductElement({
    required this.id,
    required this.image,
    required this.name,
    required this.productCategory,
    required this.price,
    required this.priceWithDiscount,
    required this.rating,
    required this.orderCount,
    required this.createdAt,
    required this.description,
    this.isFavourite,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        productCategory: json["product_category"],
        price: json["price"],
        priceWithDiscount: json["price_with_discount"],
        rating: json["rating"],
        orderCount: json["order_count"],
        createdAt: json["created_at"],
        description: json["description"],
        isFavourite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "product_category": productCategory,
        "price": price,
        "price_with_discount": priceWithDiscount,
        "rating": rating,
        "order_count": orderCount,
        "created_at": createdAt,
        "favorite": isFavourite,
        "description": description
      };

  ProductElement copyWith({
    String? id,
    String? image,
    String? name,
    String? productCategory,
    int? price,
    int? priceWithDiscount,
    double? rating,
    int? orderCount,
    String? createdAt,
    String? description,
    bool? isFavourite,
  }) {
    return ProductElement(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      productCategory: productCategory ?? this.productCategory,
      price: price ?? this.price,
      priceWithDiscount: priceWithDiscount ?? this.priceWithDiscount,
      rating: rating ?? this.rating,
      orderCount: orderCount ?? this.orderCount,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
