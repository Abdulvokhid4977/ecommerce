import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart' as main;
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart' as search;
import 'package:e_commerce/presentation/components/custom_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage<T extends Bloc> extends StatefulWidget {
  final int index;
  final T bloc;

  const ProductDetailsPage({super.key, required this.index, required this.bloc});

  @override
  State<ProductDetailsPage<T>> createState() => _ProductDetailsPageState<T>();
}

class _ProductDetailsPageState<T extends Bloc> extends State<ProductDetailsPage<T>> {
  final _controller = PageController();

  int roundDownToNearestTen(int number) {
    return (number ~/ 10) * 10;
  }

  final List<Map> _itemColor = [
    {'asset': 'assets/images/s22.jpg', 'color': 'Черный'},
    {'asset': 'assets/images/s22.jpg', 'color': 'Синий'},
    {'asset': 'assets/images/s22.jpg', 'color': 'Коричневый'},
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<main.MainBloc, main.MainState>(
      bloc: context.read<main.MainBloc>(),
      builder: (context, mainState) {
        return BlocBuilder<search.SearchBloc, search.SearchState>(
          bloc: context.read<search.SearchBloc>(),
          builder: (context, searchState) {
            if (kDebugMode) {
              print(mainState.runtimeType);
            }

            if (searchState is search.FetchCategoryProductState) {
              final product = searchState.product.product[widget.index];
              final isFavorite = product.favorite;

              print(product.name);
              return productDetails(product, isFavorite);
            } else
              if (mainState is main.MainLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (mainState is main.MainLoaded) {
              final product = mainState.products.product[widget.index];
              final isFavorite = product.favorite;
              return productDetails(product, isFavorite);
            } else if (mainState is main.FetchWishlistState) {
              final product = mainState.product.product[widget.index];
              final isFavorite = product.favorite;
              return productDetails(product, isFavorite);
            } else if (mainState is main.MainError) {
              return Center(child: Text(mainState.message));
            } else {
              return const Center(child: Text('Could not fetch from Product Details Page'));
            }
          },
        );
      },
    );
  }


  Widget productDetails(ProductElement baseState, bool isFavorite){
    final discount = ((baseState.price - baseState.withDiscount) /
        baseState.price) *
        100;
    final monthly = (baseState.withDiscount / 6).round();
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
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colours.blueCustom,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  actions: [
                    BlocConsumer<T, dynamic>(
                      bloc: widget.bloc,
                      listener: (context, state) {
                        if (state is main.FavoriteToggledState && widget.bloc is main.MainBloc) {
                          if (state.productElement.id == baseState.id) {
                            setState(() {
                              isFavorite = state.isFavorite;
                            });
                          }
                        } else if (state is search.FavoriteToggledState && widget.bloc is search.SearchBloc) {
                          if (state.productElement.id == baseState.id) {
                            setState(() {
                              isFavorite = state.isFavorite;
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            final newFavoriteStatus = !isFavorite;
                            if (widget.bloc is main.MainBloc) {
                              widget.bloc.add(
                                main.UpdateFavoriteEvent(newFavoriteStatus, baseState),
                              );
                            } else if (widget.bloc is search.SearchBloc) {
                              widget.bloc.add(
                                search.UpdateFavoriteEvent(newFavoriteStatus,baseState),
                              );
                            }
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colours.greyIcon,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        color: Colours.blueCustom,
                      ),
                      onPressed: () {},
                    ),
                  ],
                  expandedHeight: SizeConfig.screenHeight! * 0.56,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        AppUtils.kHeight32,
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.49,
                          child: PageView.builder(
                            controller: _controller,
                            itemBuilder: (ctx, i) {
                              return Image.network(
                                baseState.image,
                                height: SizeConfig.screenHeight! * 0.49,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.statusBar,
                        ),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: SlideEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: Colours.blueCustom,
                          ),
                        ),
                        AppUtils.kHeight16,
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
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
                              baseState.name,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              softWrap: true,
                            ),
                            AppUtils.kHeight16,
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colours.greyIcon,
                                        width: 1),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            baseState.rating.toString(),
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colours.yellowCustom,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '20 отзывов',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AppUtils.kWidth12,
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colours.greyIcon,
                                        width: 1),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    children: [
                                      Text(
                                        '+${roundDownToNearestTen(baseState.orderCount)}',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Заказов',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                                  _itemColor[1]['color'],
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
                                itemCount: _itemColor.length,
                                itemBuilder: (ctx, i) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colours.blueCustom,
                                        width: 1,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      color: Colours.backgroundGrey,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      child: Image.asset(
                                        _itemColor[i]['asset'],
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
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${NumberFormat('#,###', 'en_US').format(baseState.withDiscount).replaceAll(',', ' ')} сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${NumberFormat('#,###', 'en_US').format(baseState.price).replaceAll(',', ' ')} сум',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colours.greyIcon,
                              ),
                            ),
                            AppUtils.kHeight10,
                            Row(
                              children: [
                                CustomContainer().customBox(
                                  '-${NumberFormat('#,###', 'en_US').format(discount).replaceAll(',', ' ')}%',
                                  Colours.redCustom,
                                  Colors.white,
                                ),
                                AppUtils.kWidth8,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: Colours.redCustom,
                                    ),
                                    Text(
                                      '37:50:00',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colours.redCustom,
                                      ),
                                    ),
                                  ],
                                ),
                                AppUtils.kWidth8,
                                CustomContainer().customBox(
                                  'Временная скидка',
                                  Colours.redCustom,
                                  Colors.white,
                                ),
                              ],
                            ),
                            AppUtils.kHeight10,
                            CustomContainer().customBox(
                              '${NumberFormat('#,###', 'en_US').format(monthly).replaceAll(',', ' ')} сум/мес',
                              Colours.yellowCustom2,
                              Colors.black,
                            ),
                            AppUtils.kHeight10,
                            Container(
                              decoration: BoxDecoration(
                                color: Colours.backgroundGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: SizeConfig.screenHeight! * 0.065,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: CustomContainer()
                                            .customBox(
                                            'От 16 378 сум/мес',
                                            Colours.yellowCustom2,
                                            Colors.black),
                                      ),
                                      Text(
                                        'в рассрочку',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.keyboard_arrow_right),
                                  ),
                                ],
                              ),
                            ),
                            AppUtils.kHeight10,
                            customRow(Icons.check, Colours.greenCustom,
                                'В наличии 93 шт'),
                            AppUtils.kHeight10,
                            customRow(
                              Icons.shopping_bag_outlined,
                              Colours.yellowCustom3,
                              '${baseState.orderCount} человек купили на этой неделе',
                            ),
                          ],
                        ),
                      ),
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
          Positioned(
            bottom: 0,
            child: Container(
              height: SizeConfig.screenHeight! * 0.1,
              width: SizeConfig.screenWidth,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
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
                          decorationColor: Colours.greyIcon,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '${NumberFormat('#,###', 'en_US').format(baseState.withDiscount).replaceAll(',', ' ')} сум',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.blueCustom,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fixedSize: const Size(150, 50)),
                    child: Text(
                      'В корзинку',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customRow(IconData icon, Color color, String text) {
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
