import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRow extends StatelessWidget {
  final String text1;
  final String text2;
  final bool isTotal;
  const CustomRow(this.text1, this.text2,{super.key, this.isTotal=false, });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Text(
          text2,
          style: isTotal
              ? GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 17,
          )
              : GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
