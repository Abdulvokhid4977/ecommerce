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
    final height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.25,
        ),
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
        ElevatedButton(
          onPressed: () { Navigator.of(context).pushNamed(Routes.main);},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colours.blueCustom,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Go to Home Page'),
        ),
      ],
    );
  }
}
