import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/utils.dart';

class CustomRow extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  const CustomRow(this.color, this.icon, this.text,{super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          height: 24,
          width: 24,
          child: Icon(
            icon,
          ),
        ),
        AppUtils.kWidth8,
        Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
