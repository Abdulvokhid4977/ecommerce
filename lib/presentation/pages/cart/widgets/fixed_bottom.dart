import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';

class FixedBottom extends StatelessWidget {
  final double total;
  final int quantity;
  const FixedBottom(this.total, this.quantity,{super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: SizeConfig.screenHeight! * 0.1,
        width: SizeConfig.screenWidth,
        color: Colours.backgroundGrey,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppUtils.numberFormatter(total)} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '$quantity товар',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colours.greyIcon,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.givingOrder);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.blueCustom,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: const Size(150, 50)),
              child: Text(
                'Оформить',
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
