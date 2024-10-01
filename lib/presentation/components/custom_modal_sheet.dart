import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/pages/details/widgets/fixed_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/product_model.dart';

class CustomModalSheet extends StatefulWidget {
  final BuildContext context;
  final ProductElement product;

  const CustomModalSheet(this.product, this.context, {super.key});

  @override
  State<CustomModalSheet> createState() => _CustomModalSheetState();
}

class _CustomModalSheetState extends State<CustomModalSheet> {
  final cartService = GetIt.I<CartService>();
  int? selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.color[0].colorUrl.first,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      placeholder: (context, url) => Lottie.asset(
                          'assets/lottie/loading.json',
                          height: 100,
                          width: 100),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          softWrap: true,
                        ),
                        AppUtils.kHeight8,
                        Text(
                          '${AppUtils.numberFormatter(widget.product.price)} сум',
                          style: widget.product.withDiscount == 0
                              ? GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                )
                              : GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                ),
                        ),
                        widget.product.withDiscount == 0
                            ? const SizedBox()
                            : Text(
                                '${AppUtils.numberFormatter(widget.product.withDiscount)} сум',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colours.greenIndicator,
                                ),
                              ),
                        AppUtils.kHeight8,
                        Text(
                          'В наличии: ${widget.product.itemCount}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppUtils.kHeight16,
            Row(
              children: [
                const Text(
                  'Цвет: ',
                  style: TextStyle(fontSize: 16),
                ),
                AppUtils.kWidth8,
                Text(
                  selectedColorIndex != null
                      ? widget.product.color[selectedColorIndex!].colorName
                      : 'Выберите ',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            AppUtils.kHeight16,
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! * 0.12,
              child: ListView.separated(
                separatorBuilder: (ctx, i) {
                  return AppUtils.kWidth12;
                },
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.color.length,
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {
                      if (selectedColorIndex == i) {
                        setState(() {
                          selectedColorIndex = null;
                        });
                      } else {
                        setState(() {
                          selectedColorIndex = i;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedColorIndex == i
                              ? Colours.blueCustom
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colours.backgroundGrey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.color[i].colorUrl[0],
                          placeholder: (context, url) => Lottie.asset(
                              'assets/lottie/loading.json',
                              height: 100,
                              width: 100),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AppUtils.kHeight16,
            FixedBottom(widget.product, selectedColorIndex!=null? widget.product.color[selectedColorIndex!].id: null)
            // Container(
            //   width: SizeConfig.screenWidth,
            //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (selectedColorIndex != null) {
            //         cartService.addToCart(
            //           widget.product,quantity: 1,
            //         );
            //         Navigator.pop(
            //           context,
            //           widget.product.color[selectedColorIndex!].id,
            //         );
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         fixedSize: const Size(double.infinity, 56),
            //         backgroundColor: selectedColorIndex != null
            //             ? Colours.blueCustom
            //             : Colours.textFieldGrey,
            //         elevation: 0,
            //         tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            //     child: Text(
            //       'В корзину',
            //       style: GoogleFonts.inter(
            //           fontWeight: FontWeight.w400, fontSize: 20),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
