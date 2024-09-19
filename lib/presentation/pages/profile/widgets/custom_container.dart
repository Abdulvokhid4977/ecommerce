import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  final String asset;
  final String label;
  final Function function;
  final bool hasSomething ;
  final String? something;
  const CustomContainer(this.asset, this.label,this.function,{this.hasSomething=false, this.something,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
            onTap: (){function();},
            leading: SvgPicture.asset(
             asset
            ),
            title: Text(label),
            trailing: hasSomething
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  something!,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colours.greyIcon,
                  ),
                ),
                AppUtils.kWidth8,
                const Icon(Icons.keyboard_arrow_right)
              ],
            )
                : const Icon(Icons.keyboard_arrow_right),
          ),
    );
  }
}
