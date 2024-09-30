
import 'package:e_commerce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';

class OrderCount extends StatelessWidget {
  final ProductElement baseState;
  const OrderCount(this.baseState,{super.key});
  int roundDownToNearestTen(int number) {
    return (number ~/ 10) * 10;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            baseState.name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            softWrap: true,
          ),
          AppUtils.kHeight16,
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colours.greyIcon, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    Text(
                      '+${roundDownToNearestTen(baseState.itemCount)}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Заказов',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
