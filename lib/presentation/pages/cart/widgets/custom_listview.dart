import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/product_model.dart';

class CustomListview extends StatelessWidget {
  final List<CartItemWrapper> products;
  final List<bool> selectedItems;
  final Function(int, bool) onItemSelected;
  final Function(int, int) onQuantityChanged;

  const CustomListview({
    Key? key,
    required this.products,
    required this.selectedItems,
    required this.onItemSelected,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        final product = products[i];
        return Column(
          children: [
            Row(
              children: [
                Image.network(
                  product.product.color[0].colorUrl.first,
                  height: 110,
                  width: 80,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product.product.withDiscount} сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Checkbox(
                              activeColor: Colours.blueCustom,
                              value: selectedItems[i],
                              onChanged: (val) => onItemSelected(i, val!),
                            ),
                          ],
                        ),
                        Text(
                          product.product.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          softWrap: true,
                        ),
                        QuantitySelector(
                          quantity: product.quantity,
                          onChanged: (newQuantity) => onQuantityChanged(i, newQuantity),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onChanged;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 24,),
          onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
        ),
        Text(
          quantity.toString(),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 24,),
          onPressed: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}