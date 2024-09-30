import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';

class FixedBottom extends StatefulWidget {
  final double total;
  final int quantity;
  final double discount;
  final List<CartItemWrapper> products;

  const FixedBottom(this.total, this.quantity, this.discount, this.products,
      {super.key});

  @override
  State<FixedBottom> createState() => _FixedBottomState();
}

class _FixedBottomState extends State<FixedBottom> {
  String? customerId;

  void getUserId() async {
    final result = await getCustomerId();
   setState(() {
     customerId = result;

   });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

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
                  '${AppUtils.numberFormatter(widget.total)} сум',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${widget.quantity} товар',
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
                if (customerId != null) {
                  Navigator.of(context).pushNamed(Routes.givingOrder,
                      arguments: [
                        widget.total,
                        widget.quantity,
                        widget.discount,
                        widget.products
                      ]);
                } else {
                  Navigator.of(context).pushNamed(Routes.auth);
                }
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
