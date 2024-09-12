import 'package:e_commerce/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../data/models/product_model.dart';

class CustomAppBar<T extends Bloc> extends StatefulWidget {
  final ProductElement product;
  final int? _selectedColorIndex;

  const CustomAppBar(this.product, this._selectedColorIndex,
      {super.key});

  @override
  State<CustomAppBar<T>> createState() => _CustomAppBarState<T>();
}

class _CustomAppBarState<T extends Bloc> extends State<CustomAppBar<T>> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<String> allColorUrls = widget.product.getAllColorUrls();
    List<String> displayedImages = widget._selectedColorIndex != null
        ? widget.product.color[widget._selectedColorIndex!].colorUrl
        : allColorUrls;
    final baseState = widget.product;
    var isFavorite = baseState.favorite;
    return SliverAppBar(
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
      BlocBuilder<FavoriteBloc, FavoriteState>(
    builder: (context, state) {
      if (state is FavoriteToggledState &&
          state.productElement.id == widget.product.id) {
        isFavorite = state.isFavorite;
      }

      return IconButton(
        splashColor: Colors.transparent,
        onPressed: () {
          final newFavoriteStatus = !isFavorite;
          context.read<FavoriteBloc>().add(
            UpdateFavoriteStatusEvent(widget.product, newFavoriteStatus),
          );
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
          onPressed: () async {
            final result = await Share.share(
                '${baseState.name}\n${baseState.price}\n${baseState.description}');
            if (kDebugMode) {
              print(result.status);
            }
          },
        ),
      ],
      expandedHeight: SizeConfig.screenHeight! * 0.56,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double shrinkOffset = constraints.biggest.height;
          const double collapseThreshold = kToolbarHeight + 50;

          return FlexibleSpaceBar(
            title: shrinkOffset <= collapseThreshold
                ? Text(
                    baseState.name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black),
                    softWrap: true,
                  )
                : null, // No title when it's expanded
            background: Column(
              children: [
                AppUtils.kHeight32,
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.49,
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (i) {
                      if (i == displayedImages.length) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          _controller.jumpToPage(
                              0); // Jump to the first image without animation
                        });
                      }
                    },
                    itemCount: displayedImages.length,
                    itemBuilder: (ctx, i) {
                      return Image.network(
                        displayedImages[i],
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
                  count: displayedImages.length,
                  effect: SlideEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    activeDotColor: Colours.blueCustom,
                  ),
                ),
                AppUtils.kHeight16,
              ],
            ),
          );
        },
      ),
    );
  }
}
