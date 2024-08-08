import 'dart:async';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/gridtiles.dart';
import 'package:e_commerce/presentation/components/textfield.dart';
import 'package:flutter/material.dart';
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
  final _controller = PageController(viewportFraction: 0.8);
  final textEditingController = TextEditingController();
  final List<Map> _ads = [
    {'asset': 'assets/images/ads.png', 'chosen': false},
    {'asset': 'assets/images/ads.png', 'chosen': false},
    {'asset': 'assets/images/ads.png', 'chosen': true},
    {'asset': 'assets/images/ads.png', 'chosen': false},
    {'asset': 'assets/images/ads.png', 'chosen': false},
  ];
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
  List<Widget> banners = [];

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _ads.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).viewPadding.top;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    banners = List.generate(_ads.length, (i) {
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Image.asset(
              _ads[i]['asset'],
            ),
          ),
        ],
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.only(
                left: 16, top: statusBar + 20, right: 16, bottom: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: textField(
                    () {},
                    focus1,
                    textEditingController,
                    "Поиск товаров и категорий",
                    isSearch: true,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
                            height: height * 0.195,
                            child: PageView(
                              controller: _controller,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              children: banners,
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: _ads.length,
                            effect: ExpandingDotsEffect(
                                dotWidth: 8,
                                dotHeight: 8,
                                activeDotColor: Colours.blueCustom),
                          ),
                          AppUtils.kHeight10,
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16, bottom: 12),
                            child: Text(
                              'Категории',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.15,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                              separatorBuilder: (ctx,i){return AppUtils.kWidth12;},
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
                          itemCount: 10,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                                mainAxisExtent: height * 0.46,
                          ),
                          itemBuilder: (ctx, i) {
                            return const GridTileHome();
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
  }

  Future<void> _refresh() async {}
}
