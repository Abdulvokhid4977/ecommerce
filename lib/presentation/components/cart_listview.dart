import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartListview {
  Widget category(String category, BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: SizeConfig.screenHeight! * 0.4,
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return InkWell(
                onTap: () {
                  Navigator.of(ctx).pushNamed(Routes.details);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  width: SizeConfig.screenWidth! * 0.4,
                  height: 0.38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/s21.jpeg',
                        ),
                      ),
                      AppUtils.kHeight10,
                      Text(
                        'Samsung S21 Ultra 12/256gb Black',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        softWrap: true,
                      ),
                      AppUtils.kHeight10,
                      CustomContainer().customBox(
                        '109 378 сум/мес',
                        Colours.yellowCustom2,
                        Colors.black,
                      ),
                      AppUtils.kHeight10,
                      Text(
                        '1 200 000 сум',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              );
              ;
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
