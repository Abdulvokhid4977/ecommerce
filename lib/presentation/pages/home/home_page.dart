import 'dart:async';
import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/shimmers/home_shimmer.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/category_model.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/components/gridtile.dart';
import 'package:e_commerce/presentation/pages/favorites/favorites_page.dart';
import 'package:e_commerce/presentation/pages/home/widgets/banner.dart';
import 'package:e_commerce/presentation/pages/home/widgets/category_widget.dart';
import 'package:e_commerce/presentation/pages/home/widgets/searchbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  FocusNode focus1 = FocusNode();
  final textEditingController = TextEditingController();
  final _controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(FetchDataEvent(false));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget homeContent() {
    return Scaffold(
      body: Column(
        children: [
          Searchbar(textEditingController, focus1),
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              bloc: context.read<MainBloc>(),
              builder: (context, state) {
                if (kDebugMode) {
                  print(state.runtimeType);
                }
                if (state is MainLoading) {
                  return const HomeShimmer();
                } else if (state is MainLoaded) {
                  List<CategoryElement> filtered = state.category.category
                      .where((val) => val.parentId == '')
                      .toList();
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<MainBloc>().add(FetchDataEvent(false));
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          BannerWidget(state, _controller),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: state.banners.banner.length,
                            effect: ExpandingDotsEffect(
                                dotWidth: 8,
                                dotHeight: 8,
                                activeDotColor: Colours.blueCustom),
                          ),
                          AppUtils.kHeight10,
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8, bottom: 12),
                            child: Text(
                              'Категории',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          ),
                          CategoryWidget(filtered),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8, top: 12),
                            child: Text(
                              'Рекоммендуемое',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.products.product.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 6,
                                mainAxisExtent: SizeConfig.screenHeight! * 0.4,
                              ),
                              itemBuilder: (ctx, i) {
                                return GridTileProduct(
                                  state.products.product[i].favorite,
                                  state.products.product[i],
                                );
                              },
                            ),
                          ),
                          AppUtils.kHeight16,
                        ],
                      ),
                    ),
                  );
                } else if (state is FavoriteToggledState) {
                  return const SizedBox();
                } else if (state is MainError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(
                    child: Lottie.asset('assets/lottie/loading.json'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page = homeContent(); // Your default HomePage content
        if (settings.name == Routes.favorites) {
          page = const FavoritesPage(); // Navigate to Wishlist
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}
