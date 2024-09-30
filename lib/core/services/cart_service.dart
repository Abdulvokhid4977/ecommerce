import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/injection.dart';
import 'package:hive/hive.dart';
import '../../data/models/product_model.dart';

class CartService {
  static final Box<CartItemWrapper> _box = getIt<Box<CartItemWrapper>>();

  Future<void> addToCart(ProductElement product, {int quantity = 1, String colorId='5b2314d0-d2e1-4029-a413-461a6845711c'}) async {
    final existingItem = _box.get(product.id);
    if (existingItem != null) {
      await updateProductQuantity(product,colorId,existingItem.quantity + quantity);
    } else {
      await _box.put(product.id, CartItemWrapper(product: product,colorId: colorId, quantity: quantity));
    }
  }

  // Future<void> addToCart(ProductElement product, String colorId, {int quantity = 1}) async {
  //   try {
  //     final existingItem = _box.get(colorId);
  //
  //     if (existingItem != null) {
  //       // Check if the colorId matches
  //       if (existingItem.colorId == colorId) {
  //         // If same color, update the quantity
  //         await updateProductQuantity(product, colorId, existingItem.quantity + quantity);
  //       } else {
  //         // If different color, add as a new entry (or handle as you prefer)
  //         await _box.put(colorId, CartItemWrapper(product: product, colorId: colorId, quantity: quantity));
  //       }
  //     } else {
  //       // If the product does not exist in the cart, add a new item
  //       await _box.put(colorId, CartItemWrapper(product: product, colorId: colorId, quantity: quantity));
  //     }
  //   } catch (e) {
  //     // Error handling, e.g., logging or throwing a custom exception
  //     print('Error adding product to cart: $e');
  //   }
  // }


  Future<List<CartItemWrapper>> getCartProducts() async {
    return _box.values.toList();
  }

  Future<void> updateProductQuantity(ProductElement product, String colorId, int newQuantity) async {
    if (newQuantity > 0) {
      await _box.put(product.id, CartItemWrapper(product: product, colorId: colorId, quantity: newQuantity));
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
      await updateProductQuantity(item.product,item.colorId,item.quantity + 1);
    }
  }

  Future<void> decreaseQuantity(String productId) async {
    final item = _box.get(productId);
    if (item != null) {
      await updateProductQuantity(item.product,item.colorId, item.quantity - 1);
    }
  }
}