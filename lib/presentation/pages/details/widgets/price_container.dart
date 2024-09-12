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
  const PriceContainer(this.baseState,{super.key});

  @override
  Widget build(BuildContext context) {
    final discount =((baseState.price - baseState.withDiscount) / baseState.price) * 100;
    final monthly = (baseState.withDiscount / 6).round();
    return   Container(
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
          Text(
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
              fontSize: 14,
              color: Colours.greyIcon,
            ),
          ),
          AppUtils.kHeight10,
          Row(
            children: [
              CustomContainer().customBox(
                '-${NumberFormat('#,###', 'en_US').format(discount).replaceAll(',', ' ')}%',
                Colours.redCustom,
                Colors.white,
              ),
              AppUtils.kWidth8,
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colours.redCustom,
                  ),
                  Text(
                    '37:50:00',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colours.redCustom,
                    ),
                  ),
                ],
              ),
              AppUtils.kWidth8,
              CustomContainer().customBox(
                'Временная скидка',
                Colours.redCustom,
                Colors.white,
              ),
            ],
          ),
          AppUtils.kHeight10,
          CustomContainer().customBox(
            '${NumberFormat('#,###', 'en_US').format(monthly).replaceAll(',', ' ')} сум/мес',
            Colours.yellowCustom2,
            Colors.black,
          ),
          AppUtils.kHeight10,
          Container(
            decoration: BoxDecoration(
              color: Colours.backgroundGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            height: SizeConfig.screenHeight! * 0.065,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: CustomContainer().customBox(
                          'От 16 378 сум/мес',
                          Colours.yellowCustom2,
                          Colors.black),
                    ),
                    Text(
                      'в рассрочку',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon:
                  const Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
          AppUtils.kHeight10,
          CustomRow(Colours.greenCustom, Icons.check,
              'В наличии 93 шт'),
          AppUtils.kHeight10,
          CustomRow(
            Colours.yellowCustom3,
            Icons.shopping_bag_outlined,
            '${baseState.orderCount} человек купили на этой неделе',
          ),
        ],
      ),
    );
  }
}
