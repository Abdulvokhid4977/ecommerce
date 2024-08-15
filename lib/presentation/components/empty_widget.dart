import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget extends StatelessWidget {
  final String assetPath;
  final String text1;
  final String text2;
  const EmptyWidget(this.assetPath,this.text1, this.text2,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Image.asset(assetPath),
          AppUtils.kHeight32,
          Text(
            text1,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          AppUtils.kHeight10,
          Text(
            text2,
            softWrap: true,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colours.greyIcon,
            ),
          ),
          AppUtils.kHeight16,
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colours.blueCustom,
              ),
              child: Text('Go to Home Page', style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),),
            ),
            onTap: () { Navigator.of(context).pushNamed(Routes.main);},
          ),


        ],
      ),
    );
  }
}
