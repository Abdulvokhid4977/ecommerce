import 'package:e_commerce/core/services/register_service.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/data/models/location_model.dart';
import 'package:e_commerce/data/models/register_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/services/cart_service.dart';
import 'core/wrappers/cart_item_wrapper.dart';


final getIt = GetIt.instance;

Future<void> setup() async {
  final product = await Hive.openBox<CartItemWrapper>('products');
  getIt.registerSingleton<Box<CartItemWrapper>>(product);
  getIt.registerSingleton<CartService>(CartService());

  final location = await Hive.openBox<LocationElement>('locations');
  getIt.registerSingleton<Box<LocationElement>>(location);
  getIt.registerSingleton<LocationService>(LocationService());

  final user = await Hive.openBox<Register>('user');
  getIt.registerSingleton<Box<Register>>(user);
  getIt.registerSingleton<RegisterService>(RegisterService());
}
