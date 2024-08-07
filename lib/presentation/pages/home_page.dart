import 'dart:async';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
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
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              _ads[i]['asset'],
            ),
          ),
        ],
      );
    });
    return Scaffold(
      backgroundColor: Colours.backgroundGrey,
      body: Column(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.only(
                left: 16, top: statusBar + 32, right: 16, bottom: 16),
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
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
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
                      AppUtils.kHeight16,
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
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8),
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
                              ),
                            );
                          },
                          itemCount: _category.length,
                        ),
                      ),
                    ],
                  ),
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
