import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';

class FixedBottom extends StatelessWidget {
  final ProductElement baseState;

  const FixedBottom(this.baseState, {super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = GetIt.I<CartService>();
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
              children: [
                Text(
                  '${NumberFormat('#,###', 'en_US').format(baseState.price).replaceAll(',', ' ')} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colours.greyIcon,
                    decorationColor: Colours.greyIcon,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '${NumberFormat('#,###', 'en_US').format(baseState.withDiscount).replaceAll(',', ' ')} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                cartService.addToCart(CartItemWrapper(product: baseState, quantity: 1));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.blueCustom,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: const Size(150, 50)),
              child: Text(
                'В корзинку',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
