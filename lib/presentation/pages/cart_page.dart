import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final bool _isCartEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCartEmpty
          ? const EmptyWidget(
              'assets/images/shopping_bag.png',
              'Корзина пуста',
              'В вашей корзине нет товаров, подберите на товары главной странице',
            )
          : const Column(),
    );
  }
}
