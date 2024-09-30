import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/pages/details/widgets/custom_appBar.dart';
import 'package:e_commerce/presentation/pages/details/widgets/fixed_bottom.dart';
import 'package:e_commerce/presentation/pages/details/widgets/order_count.dart';
import 'package:e_commerce/presentation/pages/details/widgets/price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProductDetailsPage<T extends Bloc> extends StatefulWidget {
  final ProductElement product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage<T>> createState() => _ProductDetailsPageState<T>();
}

class _ProductDetailsPageState<T extends Bloc>
    extends State<ProductDetailsPage<T>> {
  int? _selectedColorIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final baseState = widget.product;

    return Scaffold(
      backgroundColor: Colours.backgroundGrey,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: SizeConfig.screenHeight! * 0.1,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                CustomAppBar(widget.product, _selectedColorIndex),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      OrderCount(baseState),
                      AppUtils.kHeight16,
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Цвет: ',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: Colours.greyIcon,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  _selectedColorIndex != null
                                      ? baseState
                                          .color[_selectedColorIndex!].colorName
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
                                itemCount: baseState.color.length,
                                itemBuilder: (ctx, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (_selectedColorIndex == i) {
                                        setState(() {
                                          _selectedColorIndex = null;
                                        });
                                      } else {
                                        setState(() {
                                          _selectedColorIndex = i;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _selectedColorIndex == i
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
                                          imageUrl: baseState.color[i].colorUrl[0],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Lottie.asset(
                                              'assets/lottie/loading.json',
                                              height: 140,
                                              width: 140),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppUtils.kHeight16,
                      PriceContainer(baseState),
                      AppUtils.kHeight16,
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Характеристики',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            AppUtils.kHeight10,
                            Text(
                              baseState.description,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FixedBottom(baseState, _selectedColorIndex!=null? baseState.color[_selectedColorIndex!].id: null),
        ],
      ),
    );
  }
}
