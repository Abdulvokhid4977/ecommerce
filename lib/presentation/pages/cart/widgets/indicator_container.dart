import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';

class IndicatorContainer extends StatelessWidget {
  final double total;
  const IndicatorContainer(this.total,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colours.textFieldGrey,
      ),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.186,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Бесплатно доставим в пункт выдачи',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colours.greyIcon,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.question_mark_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(total>=1000000? 'Бесплатная доставка до дома' : 'Осталось ${AppUtils.numberFormatter(1000000-total)} сум до бесплатной доставки курьером',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: total>=1000000? Colours.greenIndicator : Colours.greyIcon,
              ),
            ),
          ),
          AppUtils.kHeight16,
          LinearPercentIndicator(
            barRadius: const Radius.circular(8),
            percent: (total >= 1000000) ? 1.0 : total / 1000000,
            width: SizeConfig.screenWidth! - 64,
            backgroundColor: Colors.white,
            progressColor: Colours.greenIndicator,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '1 000 000 сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: total>=1000000? Colours.greenIndicator : Colours.greyIcon,
                  ),
                ),
                AppUtils.kWidth12,
                Icon(
                  Icons.home,
                  color:total>=1000000? Colours.greenIndicator : Colours.greyIcon,
                  size: 24,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
