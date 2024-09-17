import 'package:e_commerce/data/models/product_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/services/cart_service.dart';



final getIt = GetIt.instance;

Future<void> setup() async {
 final product = await Hive.openBox<ProductElement>('products');
 getIt.registerSingleton<Box<ProductElement>>(
  product
 );
 getIt.registerSingleton<CartService>(CartService());
}
