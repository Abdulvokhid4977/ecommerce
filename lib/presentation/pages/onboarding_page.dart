import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/components/onboarding_widgets.dart';
import 'package:e_commerce/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  int _currentPage = 0;
  final int _numPages = 3;
  final pages= [
    const OnboardingWidgets(
      1,
      'Быстро',
      'доставим ваш товар',
    ),
    const OnboardingWidgets(
      2,
      'Доставим бесплатно',
      'первые 3 заказа',
    ),
    const OnboardingWidgets(
      3,
      'Быстрая и удобная',
      'оплата заказов',
    ),
  ];

  void _nextPage() {
    setState(() {
      _currentPage = _currentPage + 1;
    });
    if(_currentPage>2){
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const HomePage(),
          ),);
    }
    controller.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 500,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: pages,
                  ),
                ),
                const SizedBox(
                  height: 58,
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(dotWidth: 8, dotHeight: 8),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fixedSize: const Size(double.infinity, 56),
                  backgroundColor: Colours.blueCustom,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Text('Продолжить'),
            ),
          ),
        ],
      ),
    );
  }
}
