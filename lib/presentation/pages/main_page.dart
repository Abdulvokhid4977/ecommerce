import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/pages/cart_page.dart';
import 'package:e_commerce/presentation/pages/home_page.dart';
import 'package:e_commerce/presentation/pages/profile_page.dart';
import 'package:e_commerce/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> tabs = [
    const HomePage(),
    const SearchPage(''),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  void _onTabTapped(int index) {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
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
            key: Constants.bottomNavigatorKey,
            onTap: _onTabTapped,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  colorFilter: ColorFilter.mode(
                      currentIndex == 0 ? Colours.blueCustom : Colours.greyCustom,
                      BlendMode.srcIn),
                ),
                label: 'Главная',
                tooltip: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  colorFilter: ColorFilter.mode(
                      currentIndex == 1 ? Colours.blueCustom : Colours.greyCustom,
                      BlendMode.srcIn),
                ),
                label: 'Поиск',
                tooltip: 'Поиск',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  colorFilter: ColorFilter.mode(
                      currentIndex == 2 ? Colours.blueCustom : Colours.greyCustom,
                      BlendMode.srcIn),
                ),
                label: 'Корзина',
                tooltip: 'Корзина',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  colorFilter: ColorFilter.mode(
                      currentIndex == 3 ? Colours.blueCustom : Colours.greyCustom,
                      BlendMode.srcIn),
                ),
                label: 'Кабинет',
                tooltip: 'Кабинет',
              ),
            ],
          ),
        );
      },
    );
  }
}
