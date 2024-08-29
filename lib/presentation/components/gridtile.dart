import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/pages/product_details_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GridTileProduct extends StatefulWidget {
  final ProductElement baseState;
  final bool isFavorite;
  final int index;
  const GridTileProduct(this.index,this.isFavorite, this.baseState,{super.key});

  @override
  State<GridTileProduct> createState() => _GridTileProductState();
}

class _GridTileProductState extends State<GridTileProduct> {
  @override
  Widget build(BuildContext context) {
    final monthly = (widget.baseState.withDiscount / 6).round();
    bool isFavorite=widget.isFavorite;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                index: widget.index,
              ),
            ));
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 180,
                  width: 180,
                  child: Image.network(
                    widget.baseState.image,
                  ),
                ),
              ),
              AppUtils.kHeight10,
              Text(
                widget.baseState.name,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                softWrap: true,
              ),
              AppUtils.kHeight10,
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colours.yellowCustom,
                  ),
                  Text(
                    '${widget.baseState.rating} (${widget.baseState.orderCount} заказов)',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colours.greyIcon,
                    ),
                  ),
                ],
              ),
              AppUtils.kHeight10,
              Container(
                padding: const EdgeInsets.all(4),
                width: SizeConfig.screenWidth! * 0.37,
                decoration: BoxDecoration(
                  color: Colours.yellowCustom2,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${NumberFormat('#,###', 'en_US').format(monthly).replaceAll(',', ' ')} сум/мес',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppUtils.kHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${NumberFormat('#,###', 'en_US').format(widget.baseState.price).replaceAll(',', ' ')} сум',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colours.greyIcon,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '${NumberFormat('#,###', 'en_US').format(widget.baseState.withDiscount).replaceAll(',', ' ')} сум',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {},
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
          Positioned(
            right: 9,
            child: BlocConsumer<MainBloc, MainState>(
              listener: (context, state) {
                if (state is FavoriteToggledState &&
                    state.productElement.id == widget.baseState.id) {
                  print(state.productElement.id);
                  print(widget.baseState.id);
                  setState(() {
                    isFavorite = state.isFavorite;
                  });
                }
              },
              builder: (context, state) {
                return IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    final newFavoriteStatus = !isFavorite;
                    context.read<MainBloc>().add(UpdateFavoriteEvent(newFavoriteStatus, widget.baseState));
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colours.greyIcon,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: SizeConfig.screenHeight! * 0.187,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
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
    );
  }
}
