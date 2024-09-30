import 'package:e_commerce/data/models/register_model.dart';
import 'package:e_commerce/injection.dart';
import 'package:hive/hive.dart';

class RegisterService{
  static final Box<Register> _box = getIt<Box<Register>>();

  Future<void> addToCart(Register customer) async {
    await _box.put(customer.id, customer);
    }

  Future<List<Register>> getCartProducts() async {
    return _box.values.toList();
  }

  Future<void> clearCustomer() async {
    await _box.clear();
  }

}