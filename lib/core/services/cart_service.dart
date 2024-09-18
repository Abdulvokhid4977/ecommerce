import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/injection.dart';
import 'package:hive/hive.dart';
import '../../data/models/product_model.dart';

class CartService {
  static final Box<CartItemWrapper> _box = getIt<Box<CartItemWrapper>>();

  Future<void> addToCart(ProductElement product, {int quantity = 1}) async {
    final existingItem = _box.get(product.id);
    if (existingItem != null) {
      await updateProductQuantity(product, existingItem.quantity + quantity);
    } else {
      await _box.put(product.id, CartItemWrapper(product: product, quantity: quantity));
    }
  }

  Future<List<CartItemWrapper>> getCartProducts() async {
    return _box.values.toList();
  }

  Future<void> updateProductQuantity(ProductElement product, int newQuantity) async {
    if (newQuantity > 0) {
      await _box.put(product.id, CartItemWrapper(product: product, quantity: newQuantity));
    } else {
      await removeFromCart([product.id]);
    }
  }

  Future<void> removeFromCart(List<String> productIds) async {
    await _box.deleteAll(productIds);
  }

  Future<void> clearCart() async {
    await _box.clear();
  }

  CartItemWrapper? getCartItem(String productId) {
    return _box.get(productId);
  }

  Future<void> increaseQuantity(String productId) async {
    final item = _box.get(productId);
    if (item != null) {
      await updateProductQuantity(item.product, item.quantity + 1);
    }
  }

  Future<void> decreaseQuantity(String productId) async {
    final item = _box.get(productId);
    if (item != null) {
      await updateProductQuantity(item.product, item.quantity - 1);
    }
  }
}