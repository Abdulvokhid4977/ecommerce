import 'dart:async';

import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/components/gridtiles.dart';
import 'package:e_commerce/presentation/components/textfield.dart';
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
  final _controller = PageController(viewportFraction: 0.8);
  final List<Map> _category = [
    {'asset': 'assets/images/kategoriya1.png', 'label': 'Распродажа'},
    {'asset': 'assets/images/kategoriya2.png', 'label': 'Автотовары'},
    {'asset': 'assets/images/kategoriya3.png', 'label': 'Бытовая техника'},
    {'asset': 'assets/images/kategoriya1.png', 'label': 'Распродажа'},
    {'asset': 'assets/images/kategoriya1.png', 'label': 'Распродажа'},
    {'asset': 'assets/images/kategoriya1.png', 'label': 'Распродажа'},
    {'asset': 'assets/images/kategoriya1.png', 'label': 'Распродажа'},
    {'asset': 'assets/images/kategoriya1.png', 'label': 'Распродажа'},
  ];

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
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      bloc: context.read<MainBloc>(),
      builder: (context, state) {
        if (kDebugMode) {
          print(state.runtimeType);
        }
        if (state is MainLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MainLoaded) {
          if (_timer == null) {
            _startTimer(state.banners.banner.length);
          }
          return Scaffold(
            body: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(
                    left: 16,
                    top: SizeConfig.statusBar! + 20,
                    right: 16,
                    bottom: 16,
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.8,
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
                          Navigator.of(context)
                              .pushNamed(Routes.favorites);
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
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
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
                                  height: SizeConfig.screenHeight! * 0.23,
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
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
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
                                      left: 16, bottom: 12),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    separatorBuilder: (ctx, i) {
                                      return AppUtils.kWidth12;
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, i) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Image.asset(_category[i]['asset']),
                                            AppUtils.kHeight10,
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                _category[i]['label'],
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
                                    itemCount: _category.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colours.backgroundGrey,
                            height: 12,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16, top: 12),
                            child: Text(
                              'Рекоммендуемое',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.products.data.product.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  mainAxisExtent:
                                      SizeConfig.screenHeight! * 0.46,
                                ),
                                itemBuilder: (ctx, i) {
                                  return  GridTileHome(i);
                                }),
                          ),
                          AppUtils.kHeight16,
                        ],
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

  Future<void> _refresh() async {}
}
