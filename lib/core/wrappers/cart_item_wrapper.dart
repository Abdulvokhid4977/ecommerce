import 'package:e_commerce/data/models/product_model.dart';
import 'package:hive/hive.dart';

part 'cart_item_wrapper.g.dart';

@HiveType(typeId: 2)
class CartItemWrapper extends HiveObject {
  @HiveField(0)
  final ProductElement product;

  @HiveField(1)
  int quantity;

  CartItemWrapper({
    required this.product,
    required this.quantity,
  });
}
