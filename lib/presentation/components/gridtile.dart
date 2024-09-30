import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/pages/details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../bloc/favorite/favorite_bloc.dart';
import 'custom_modal_sheet.dart';

class GridTileProduct extends StatefulWidget {
  final ProductElement baseState;
  final bool isFavorite;

  const GridTileProduct(
    this.isFavorite,
    this.baseState, {
    super.key,
  });

  @override
  State<GridTileProduct> createState() => _GridTileProductState();
}

class _GridTileProductState extends State<GridTileProduct> {
  List<CartItemWrapper> savedProducts = [];
  final cartService = GetIt.I<CartService>();

  void savedProductsList() async {
    final fetchedData = await cartService.getCartProducts();
    setState(() {
      savedProducts = fetchedData;
    });
  }

  @override
  void initState() {
    savedProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final monthly = (widget.baseState.withDiscount / 6).round();
    final formatter = NumberFormat('#,###', 'en_US');
    String colorId = '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: widget.baseState,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: SizeConfig.screenHeight! * 0.2,
            width: SizeConfig.screenWidth! * 0.438,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.baseState.color[0].colorUrl[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      final currentFavoriteStatus =
                          state is FavoriteToggledState &&
                                  state.productElement.id == widget.baseState.id
                              ? state.isFavorite
                              : widget.isFavorite;

                      return IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          final newFavoriteStatus = !currentFavoriteStatus;
                          context.read<FavoriteBloc>().add(
                                UpdateFavoriteStatusEvent(
                                    widget.baseState, newFavoriteStatus),
                              );
                        },
                        icon: Icon(
                          currentFavoriteStatus
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: currentFavoriteStatus
                              ? Colors.red
                              : Colours.greyIcon,
                        ),
                      );
                    },
                  ),
                ),
                widget.baseState.status == ' '
                    ? const SizedBox()
                    : Positioned(
                        bottom: 5,
                        left: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: widget.baseState.status == 'novinka'
                                ? Colours.greenIndicator
                                : Colours.blueCustom,
                          ),
                          child: Text(
                            widget.baseState.status == 'vremennaya_skidka'
                                ? 'Скидка'
                                : widget.baseState.status == 'novinka'
                                    ? 'Новинка'
                                    : '',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.baseState.name,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            softWrap: true,
          ),
          const SizedBox(height: 10),
          // Container(
          //   padding: const EdgeInsets.all(4),
          //   width: SizeConfig.screenWidth! * 0.37,
          //   decoration: BoxDecoration(
          //     color: Colours.yellowCustom2,
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          //   child: Text(
          //     '${formatter.format(monthly).replaceAll(',', ' ')} сум/мес',
          //     style: GoogleFonts.inter(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 16,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${formatter.format(widget.baseState.price).replaceAll(',', ' ')} сум',
                    style: widget.baseState.withDiscount == 0
                        ? GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )
                        : GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colours.greyIcon,
                            decoration: TextDecoration.lineThrough,
                          ),
                  ),
                  widget.baseState.withDiscount == 0
                      ? const SizedBox()
                      : Text(
                          '${formatter.format(widget.baseState.withDiscount).replaceAll(',', ' ')} сум',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  final result = await showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return CustomModalSheet(widget.baseState, context);
                    },
                  );
                  if (result != null) {
                    cartService.addToCart(widget.baseState);
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colours.backgroundGrey,
                  radius: 25,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colours.greyIcon, width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/icons/cart.svg',
                        colorFilter: ColorFilter.mode(
                          savedProducts.contains(widget.baseState)
                              ? Colours.blueCustom
                              : Colours.greyIcon,
                          BlendMode.srcIn,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
