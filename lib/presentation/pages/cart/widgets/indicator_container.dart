import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';

class IndicatorContainer extends StatelessWidget {
  const IndicatorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    int? total = 90000;
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colours.textFieldGrey,
      ),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.18,
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
          Text(
            'Осталось 360 000 сум до бесплатной доставки курьером',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colours.greyIcon,
            ),
          ),
          AppUtils.kHeight16,
          LinearPercentIndicator(
            barRadius: const Radius.circular(8),
            percent: total! * 0.000001,
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
                  '1000000 сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colours.greyIcon,
                  ),
                ),
                AppUtils.kWidth12,
                Icon(
                  Icons.home,
                  color: Colours.greyIcon,
                  size: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
