import 'package:e_commerce/injection.dart';
import 'package:hive/hive.dart';

import '../../data/models/product_model.dart';

class CartService {
  static const String cartBoxName = 'cart';

  Future<void> addToCart(ProductElement product) async {
    final box = getIt<Box<ProductElement>>();
    await box.put(cartBoxName, product);
    print('added to hive');
  }

  Future<List<ProductElement>> getCartProducts() async {
    final box = getIt<Box<ProductElement>>();
    return box.values.toList();
  }

  Future<void> removeFromCart(String productId) async {
    final box = await Hive.openBox<ProductElement>(cartBoxName);
    await box.delete(productId);
  }

  Future<void> clearCart() async {
    final box = await Hive.openBox<ProductElement>(cartBoxName);
    await box.clear();
  }
}
