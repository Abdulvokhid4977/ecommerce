import 'dart:async';

import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/category_model.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/components/gridtiles.dart';
import 'package:e_commerce/presentation/components/textfield.dart';
import 'package:e_commerce/presentation/pages/favorites_page.dart';
import 'package:e_commerce/presentation/pages/search_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  Timer? _timer;
  FocusNode focus1 = FocusNode();
  final textEditingController = TextEditingController();
  final _controller = PageController(viewportFraction: 0.9);

  void _startTimer(int bannerLength) {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerLength - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.only(
              left: 8,
              top: SizeConfig.statusBar! + 20,
              right: 8,
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.84,
                  child: textField(
                    () {},
                    focus1,
                    textEditingController,
                    "Поиск товаров и категорий",
                    isSearch: true,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<MainBloc>().add(FetchDataEvent(true));
                    Navigator.of(context).pushNamed(Routes.favorites);
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colours.greyIcon,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MainBloc, MainState>(
            bloc: context.read<MainBloc>(),
            builder: (context, state) {
              if (kDebugMode) {
                print(state.runtimeType);
              }
              if (state is MainLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is MainLoaded) {
                if (_timer == null) {
                  _startTimer(state.banners.banner.length);
                }
                List<CategoryElement> filtered = state.category.category
                    .where((val) => val.parentId == '')
                    .toList();
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MainBloc>().add(FetchDataEvent(false));
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.screenHeight! * 0.25,
                                  child: PageView(
                                    controller: _controller,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                    children: List.generate(
                                        state.banners.banner.length, (i) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 8,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            state.banners.banner[i].bannerImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
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
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 12),
                                  child: Text(
                                    'Категории',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight! * 0.15,
                                  child: ListView.separated(
                                    physics: const ClampingScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    separatorBuilder: (ctx, i) {
                                      return AppUtils.kWidth2;
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          context.read<MainBloc>().add(ChangeTabEvent(1));
                                          context.read<SearchBloc>().add(
                                              FetchSearchDataEvent(
                                                  filtered[i].id, false));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchPage(filtered[i].id),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  filtered[i].url,
                                                  // state.category.category[i].url,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            AppUtils.kHeight10,
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                filtered[i].name,
                                                // state.category.category[i].name,
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: filtered.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   color: Colours.backgroundGrey,
                          //   height: 12,
                          // ),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  mainAxisExtent:
                                      SizeConfig.screenHeight! * 0.46,
                                ),
                                itemBuilder: (ctx, i) {
                                  return GridTileHome(i);
                                }),
                          ),
                          AppUtils.kHeight16,
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is MainError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Could not fetch HomePage'));
              }
            },
          )
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
