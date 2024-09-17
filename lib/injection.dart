import 'package:e_commerce/data/models/product_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/services/cart_service.dart';
import 'core/wrappers/cart_item_wrapper.dart';



final getIt = GetIt.instance;

Future<void> setup() async {
 final product = await Hive.openBox<CartItemWrapper>('products');
 getIt.registerSingleton<Box<CartItemWrapper>>(
  product
 );
 getIt.registerSingleton<CartService>(CartService());
}
