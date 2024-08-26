
import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/pages/cart_page.dart';
import 'package:e_commerce/presentation/pages/home_page.dart';
import 'package:e_commerce/presentation/pages/profile_page.dart';
import 'package:e_commerce/presentation/pages/search_page.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
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
  List tabs = [
    const HomePage(),
    const SearchPage(),
    const CartPage(),
    const ProfilePage(),
  ];
//   void setupPushNotifications() async{
//     final fcm= FirebaseMessaging.instance;
//     await fcm.requestPermission();
//     final token= await fcm.getToken();
//     if (kDebugMode) {
//       print('this is device token: $token');
//     }
// }
  @override
  void initState() {
    super.initState();
    // setupPushNotifications();

  }
  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colours.backgroundGrey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colours.blueCustom,
        unselectedItemColor: Colours.greyCustom,
        key: Constants.bottomNavigatorKey,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        currentIndex: currentIndex,
        items: [
          _navigationBarItem(
            label: 'Главная',
            icon: _buildSvgIcon('assets/icons/home.svg', 0),
          ),
          _navigationBarItem(
            label: 'Каталог',
            icon: _buildSvgIcon('assets/icons/search.svg', 1),
          ),
          _navigationBarItem(
            label: 'Корзина',
            icon: _buildSvgIcon('assets/icons/cart.svg', 2),
          ),
          _navigationBarItem(
            label: 'Кабинет',
            icon: _buildSvgIcon('assets/icons/profile.svg', 3),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navigationBarItem({
    required String label,
    required Widget icon,
  }) =>
      BottomNavigationBarItem(
        icon: icon,
        label: label,
        tooltip: label,
      );

  Widget _buildSvgIcon(String assetName, int index) {
    return SvgPicture.asset(
      assetName,
      colorFilter: ColorFilter.mode(currentIndex == index ? Colours.blueCustom : Colours.greyCustom,BlendMode.srcIn),
    );
  }
}

