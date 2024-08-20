import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GridTileHome extends StatefulWidget {
  const GridTileHome(this.index, {super.key});

  final int index;

  @override
  State<GridTileHome> createState() => _GridTileHomeState();
}

class _GridTileHomeState extends State<GridTileHome> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      bloc: context.read<MainBloc>(),
      builder: (context, state) {
        if (state is MainLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MainLoaded) {
          final baseState = state.products.data.product[widget.index];
          final monthly = (baseState.priceWithDiscount / 6).round();
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
                      child: Image.network(
                        baseState.image,
                      ),
                    ),
                    AppUtils.kHeight10,
                    Text(
                      baseState.name,
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
                          '${baseState.rating} (${baseState.orderCount} заказов)',
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 2),
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
                          children: [
                            Text(
                              '${NumberFormat('#,###', 'en_US').format(baseState.price).replaceAll(',', ' ')} сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colours.greyIcon,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '${NumberFormat('#,###', 'en_US').format(baseState.priceWithDiscount).replaceAll(',', ' ')} сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colours.greyIcon, width: 1),
                                  shape: BoxShape.circle),
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
                  top: 1,
                  right: 1,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: _isFavorite ? Colors.red : Colours.greyIcon,
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.screenHeight! * 0.187,
                  left: 4,
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
          );
        } else if (state is MainError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Could not fetch'));
        }
      },
    );
  }
}
