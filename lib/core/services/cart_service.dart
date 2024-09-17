import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/injection.dart';
import 'package:hive/hive.dart';

import '../../data/models/product_model.dart';

class CartService {
  static const String cartBoxName = 'cart';
  static final box = getIt<Box<CartItemWrapper>>();
  Future<void> addToCart(CartItemWrapper product) async {
    await box.put(product.product.id, product);


  }

  Future<List<CartItemWrapper>> getCartProducts() async {
    final box = getIt<Box<CartItemWrapper>>();
    return box.values.toList();
  }
  Future<void> updateProductQuantity(ProductElement product, int newQuantity) async {
    final cartItem = box.get(product.id);
    if (cartItem != null) {

      cartItem.quantity = newQuantity;
      await cartItem.save();
    } else {

      await addToCart(CartItemWrapper(product: product, quantity: newQuantity));
    }
  }

  Future<void> removeFromCart(List<String> productIds) async {


    for (String productId in productIds) {
      await box.delete(productId);
    }
  }

  Future<void> clearCart() async {
    await box.clear();
    print('Cleared');
  }
}
