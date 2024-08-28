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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        count: json["count"] ?? 0,
        product: json["product"] != null
            ? List<ProductElement>.from(
                json["product"].map((x) => ProductElement.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class ProductElement {
  String id;
  String categoryId;
  bool favorite;
  String image;
  String name;
  int price;
  int withDiscount;
  double rating;
  String description;
  int orderCount;
  String createdAt;

  ProductElement({
    required this.id,
    required this.categoryId,
    required this.favorite,
    required this.image,
    required this.name,
    required this.price,
    required this.withDiscount,
    required this.rating,
    required this.description,
    required this.orderCount,
    required this.createdAt,
  });

  ProductElement copyWith({
    String? id,
    String? categoryId,
    bool? favorite,
    String? image,
    String? name,
    int? price,
    int? withDiscount,
    double? rating,
    String? description,
    int? orderCount,
    String? createdAt,
  }) =>
      ProductElement(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        favorite: favorite ?? this.favorite,
        image: image ?? this.image,
        name: name ?? this.name,
        price: price ?? this.price,
        withDiscount: withDiscount ?? this.withDiscount,
        rating: rating ?? this.rating,
        description: description ?? this.description,
        orderCount: orderCount ?? this.orderCount,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        categoryId: json["category_id"],
        favorite: json["favorite"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        withDiscount: json["with_discount"],
        rating: json["rating"]?.toDouble(),
        description: json["description"],
        orderCount: json["order_count"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "favorite": favorite,
        "image": image,
        "name": name,
        "price": price,
        "with_discount": withDiscount,
        "rating": rating,
        "description": description,
        "order_count": orderCount,
        "created_at": createdAt,
      };
}
