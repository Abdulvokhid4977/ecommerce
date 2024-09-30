// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  OrderClass order;
  List<Item> items;

  Order({
    required this.order,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    order: OrderClass.fromJson(json["order"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": order.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String id;
  String orderId;
  String productId;
  int quantity;
  int price;
  int total;
  DateTime createdAt;

  Item({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    total: json["total"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "total": total,
    "created_at": createdAt.toIso8601String(),
  };
}

class OrderClass {
  String id;
  String customerId;
  int totalPrice;
  String status;
  String deliveryStatus;
  String paymentMethod;
  String paymentStatus;
  DateTime createdAt;

  OrderClass({
    required this.id,
    required this.customerId,
    required this.totalPrice,
    required this.status,
    required this.deliveryStatus,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
  });

  factory OrderClass.fromJson(Map<String, dynamic> json) => OrderClass(
    id: json["id"],
    customerId: json["customer_id"],
    totalPrice: json["total_price"],
    status: json["status"],
    deliveryStatus: json["delivery_status"],
    paymentMethod: json["payment_method"],
    paymentStatus: json["payment_status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "total_price": totalPrice,
    "status": status,
    "delivery_status": deliveryStatus,
    "payment_method": paymentMethod,
    "payment_status": paymentStatus,
    "created_at": createdAt.toIso8601String(),
  };
}
