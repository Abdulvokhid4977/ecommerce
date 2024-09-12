import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/custom_container.dart';

class CustomListview extends StatefulWidget {
  final List<bool> isSelected;

  const CustomListview(this.isSelected, {super.key});

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  @override
  Widget build(BuildContext context) {
    int num = 0;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (ctx, i) {
        return Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/s22.jpg',
                  height: 110,
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth! - 128,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    '899 000 сум',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  AppUtils.kWidth12,
                                  Text(
                                    '950 000 сум',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colours.greyIcon,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                                activeColor: Colours.blueCustom,
                                value: widget.isSelected[i],
                                onChanged: (val) {
                                  setState(() {
                                    widget.isSelected[i] =
                                        !widget.isSelected[i];
                                  });
                                }),
                          ],
                        ),
                      ),
                      AppUtils.kHeight8,
                      CustomContainer().customBox(
                        'Временная скидка',
                        Colours.redCustom,
                        Colors.white,
                      ),
                      AppUtils.kHeight16,
                      Text(
                        'Samsung S22 Ultra 12/256gb Black ',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 76,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colours.backgroundGrey,
                  ),
                  margin: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            if (num > 0) {
                              setState(() {
                                num--;
                              });
                            }
                          },
                          child: const Icon(
                            Icons.remove,
                            size: 24,
                          ),
                        ),
                      ),
                      AppUtils.kWidth8,
                      Text(
                        num.toString(),
                      ),
                      AppUtils.kWidth8,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            num++;
                          },
                          child: const Icon(
                            Icons.add,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
      itemCount: 2,
    );
  }
}
