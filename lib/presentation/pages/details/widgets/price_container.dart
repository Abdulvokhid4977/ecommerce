import 'package:e_commerce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/custom_container.dart';
import 'custom_row.dart';

class PriceContainer extends StatelessWidget {
  final ProductElement baseState;

  const PriceContainer(this.baseState, {super.key});

  @override
  Widget build(BuildContext context) {
    print(baseState.discountPercent);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          baseState.withDiscount == 0
              ? const SizedBox()
              : Text(
                  '${NumberFormat('#,###', 'en_US').format(baseState.withDiscount).replaceAll(',', ' ')} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
          Text(
            '${NumberFormat('#,###', 'en_US').format(baseState.price).replaceAll(',', ' ')} сум',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: baseState.withDiscount == 0 ? 18 : 14,
              color:
                  baseState.withDiscount == 0 ? Colors.black : Colours.greyIcon,
            ),
          ),
          AppUtils.kHeight10,
          baseState.withDiscount == 0
              ? AppUtils.kHeight16
              : Row(
                  children: [
                    CustomContainer().customBox(
                      '-${baseState.discountPercent}%',
                      Colours.greenIndicator,
                      Colors.white,
                    ),
                    AppUtils.kWidth8,
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.watch_later_outlined,
                    //       color: Colours.redCustom,
                    //     ),
                    //     Text(
                    //       '37:50:00',
                    //       style: GoogleFonts.inter(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 16,
                    //         color: Colours.redCustom,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    AppUtils.kWidth8,
                    CustomContainer().customBox(
                      ' Скидка ',
                      Colours.redCustom,
                      Colors.white,
                    ),
                  ],
                ),
          AppUtils.kHeight32,
          CustomRow(Colours.greenCustom, Icons.check, 'В наличии ${baseState.itemCount} шт'),
          AppUtils.kHeight10,
          CustomRow(
            Colours.yellowCustom3,
            Icons.shopping_bag_outlined,
            '${baseState.itemCount} человек купили на этой неделе',
          ),
        ],
      ),
    );
  }
}
