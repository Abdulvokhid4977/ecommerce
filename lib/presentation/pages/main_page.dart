import 'dart:async';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cart_service.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/pages/cart/cart_page.dart';
import 'package:e_commerce/presentation/pages/home/home_page.dart';
import 'package:e_commerce/presentation/pages/profile/profile_page.dart';
import 'package:e_commerce/presentation/pages/search/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<FormState> bottomNavigatorKey = GlobalKey<FormState>();

  int currentIndex = 0;
  DateTime? lastPressed;

  final List<Widget> tabs = [
    const HomePage(),
    const SearchPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // CartService().clearCart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  void _onTabTapped(int index) {
    if (currentIndex == 0 && index == 0) {
      return;
    }
    setState(() {
      currentIndex = index;
    });
    context.read<MainBloc>().add(ChangeTabEvent(index));

    if (index == 1) {
      context.read<SearchBloc>().add(FetchSearchDataEvent('', true));
    } else if (index == 0) {
      context.read<MainBloc>().add(FetchDataEvent(false));
    }
  }

  Future<bool> _onWillPop() async {
    if (currentIndex != 0) {
      setState(() {
        currentIndex = 0;
      });
      context.read<MainBloc>().add(ChangeTabEvent(0));
      return false;
    }

    final now = DateTime.now();
    if (lastPressed == null ||
        now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is TabChangedState) {
            currentIndex = state.currentIndex;
          }

          return Scaffold(
            body: tabs[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colours.backgroundGrey,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              selectedItemColor: Colours.blueCustom,
              unselectedItemColor: Colours.greyCustom,
              key: bottomNavigatorKey,
              onTap: _onTabTapped,
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    colorFilter: ColorFilter.mode(
                        currentIndex == 0
                            ? Colours.blueCustom
                            : Colours.greyCustom,
                        BlendMode.srcIn),
                  ),
                  label: 'Главная',
                  tooltip: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    colorFilter: ColorFilter.mode(
                        currentIndex == 1
                            ? Colours.blueCustom
                            : Colours.greyCustom,
                        BlendMode.srcIn),
                  ),
                  label: 'Поиск',
                  tooltip: 'Поиск',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/cart.svg',
                    colorFilter: ColorFilter.mode(
                        currentIndex == 2
                            ? Colours.blueCustom
                            : Colours.greyCustom,
                        BlendMode.srcIn),
                  ),
                  label: 'Корзина',
                  tooltip: 'Корзина',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    colorFilter: ColorFilter.mode(
                        currentIndex == 3
                            ? Colours.blueCustom
                            : Colours.greyCustom,
                        BlendMode.srcIn),
                  ),
                  label: 'Кабинет',
                  tooltip: 'Кабинет',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
