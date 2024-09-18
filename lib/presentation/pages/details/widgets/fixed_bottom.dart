import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';

class FixedBottom extends StatefulWidget {
  final ProductElement baseState;

  const FixedBottom(this.baseState, {Key? key}) : super(key: key);

  @override
  State<FixedBottom> createState() => _FixedBottomState();
}

class _FixedBottomState extends State<FixedBottom> {
  final CartService cartService = GetIt.I<CartService>();
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _updateQuantity();
  }

  void _updateQuantity() {
    final cartItem = cartService.getCartItem(widget.baseState.id);
    setState(() {
      quantity = cartItem?.quantity ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: SizeConfig.screenHeight! * 0.1,
        width: SizeConfig.screenWidth,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${NumberFormat('#,###', 'en_US').format(widget.baseState.price).replaceAll(',', ' ')} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colours.greyIcon,
                    decorationColor: Colours.greyIcon,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '${NumberFormat('#,###', 'en_US').format(widget.baseState.withDiscount).replaceAll(',', ' ')} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            quantity > 0 ? _buildQuantityControls() : _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Container(
      decoration: BoxDecoration(
        color: Colours.blueCustom,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: () async {
              await cartService.decreaseQuantity(widget.baseState.id);
              _updateQuantity();
            },
          ),
          Text(
            '$quantity',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              await cartService.increaseQuantity(widget.baseState.id);
              _updateQuantity();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () async {
        await cartService.addToCart(widget.baseState);
        _updateQuantity();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.blueCustom,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: const Size(150, 50),
      ),
      child: Text(
        'В корзинку',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
