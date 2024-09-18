import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/pages/details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../bloc/favorite/favorite_bloc.dart';

class GridTileProduct extends StatelessWidget {
  final ProductElement baseState;
  final bool isFavorite;

  const GridTileProduct(
    this.isFavorite,
    this.baseState, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartService = GetIt.I<CartService>();
    final monthly = (baseState.withDiscount / 6).round();
    final formatter = NumberFormat('#,###', 'en_US');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: baseState,
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
                      baseState.color[0].colorUrl[0],
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
                                  state.productElement.id == baseState.id
                              ? state.isFavorite
                              : isFavorite;

                      return IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          final newFavoriteStatus = !currentFavoriteStatus;
                          context.read<FavoriteBloc>().add(
                                UpdateFavoriteStatusEvent(
                                    baseState, newFavoriteStatus),
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
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colours.blueCustom,
                    ),
                    child: Text(
                      'Распродажа',
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
            baseState.name,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            softWrap: true,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(4),
            width: SizeConfig.screenWidth! * 0.37,
            decoration: BoxDecoration(
              color: Colours.yellowCustom2,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${formatter.format(monthly).replaceAll(',', ' ')} сум/мес',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${formatter.format(baseState.price).replaceAll(',', ' ')} сум',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colours.greyIcon,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    '${formatter.format(baseState.withDiscount).replaceAll(',', ' ')} сум',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  cartService.addToCart(baseState);
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
                    child: SvgPicture.asset(
                      'assets/icons/cart.svg',
                    ),
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
