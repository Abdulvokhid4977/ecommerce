import 'package:chuck_interceptor/chuck.dart';
import 'package:e_commerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/pages/auth/pages/auth_page.dart';
import 'package:e_commerce/presentation/pages/cart/cart_page.dart';
import 'package:e_commerce/presentation/pages/auth/pages/confirm_code.dart';
import 'package:e_commerce/presentation/pages/error/pages/disconnected.dart';
import 'package:e_commerce/presentation/pages/error/pages/error_page.dart';
import 'package:e_commerce/presentation/pages/favorites/favorites_page.dart';
import 'package:e_commerce/presentation/pages/order/pages/giving_order.dart';
import 'package:e_commerce/presentation/pages/main_page.dart';
import 'package:e_commerce/presentation/pages/onboarding_page/onboarding_page.dart';
import 'package:e_commerce/presentation/pages/order/pages/order_page.dart';
import 'package:e_commerce/presentation/pages/profile/widgets/pages/profile_page.dart';
import 'package:e_commerce/presentation/pages/auth/pages/register_page.dart';
import 'package:e_commerce/presentation/pages/search/pages/search_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'name_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();

// final localSource = sl<LocalSource>();

final Chuck chuck = Chuck(navigatorKey: rootNavigatorKey);

sealed class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('route : ${settings.name}');
    }
    switch (settings.name) {
    case Routes.initial:
    return MaterialPageRoute(
    builder: (_) => const OnboardingPage(),
    );
    case Routes.main:
    return MaterialPageRoute(
    builder: (_) => const MainPage(),
    );
    case Routes.auth:
    return MaterialPageRoute(
    builder: (_) => BlocProvider(
    create: (_) => AuthBloc(),
    child: const AuthPage(),
    ),
    );
    case Routes.favorites:
      return MaterialPageRoute(
        builder: (_) => const FavoritesPage(),
      );
    case Routes.search:
    return MaterialPageRoute(
    builder: (_) => const SearchPage(),
    );
    case Routes.givingOrder:
    return MaterialPageRoute(
    builder: (_) => const GivingOrder(),
    );
    case Routes.disconnected:
    return MaterialPageRoute(
    builder: (_) => const Disconnected(),
    );
    // case Routes.confirmCode:
    //   return MaterialPageRoute(
    //     builder: (_) => const ConfirmCode(),
    //   );
    // case Routes.selectLang:
    //   return MaterialPageRoute(builder: (_) => const SelectLang());
    // case Routes.shopping:
    //   return MaterialPageRoute(builder: (_) => const ShoppingCartPage());
    // case Routes.order:
    // return MaterialPageRoute(builder: (_) => const OrderPage());
    case Routes.cart:
    return MaterialPageRoute(builder: (_) => const CartPage());
    case Routes.profile:
    return MaterialPageRoute(builder: (_) => const ProfilePage());
    //   case Routes.internetConnection:
    //     return MaterialPageRoute(
    //       builder: (_) => const InternetConnectionPage(),
    //     );
    //   case Routes.auth:
    //     return MaterialPageRoute(
    //       builder: (_) => BlocProvider(
    //         create: (_) => sl<AuthBloc>(),
    //         child: const AuthPage(),
    //       ),
    //     );
    case Routes.confirmCode:
    // final AuthSuccessState state = settings.arguments! as AuthSuccessState;
    return MaterialPageRoute(
    builder: (_) => const ConfirmCode(''),
    );
    case Routes.register:
    return MaterialPageRoute(
    builder: (_) => const RegisterPage(),
    );

    default:
    return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigate to: $settings');
    }
    return MaterialPageRoute(
      builder: (_) =>
          ErrorPage(
            settings: settings,
          ),
    );
  }
}
//
// class FadePageRoute<T> extends PageRouteBuilder<T> {
//   FadePageRoute({required this.builder})
//       : super(
//     pageBuilder: (
//         context,
//         animation,
//         secondaryAnimation,
//         ) =>
//         builder(context),
//     transitionsBuilder: (
//         context,
//         animation,
//         secondaryAnimation,
//         child,
//         ) =>
//         FadeTransition(
//           opacity: animation,
//           child: child,
//         ),
//   );
//   final WidgetBuilder builder;
//
//   @override
//   bool get maintainState => true;
//
//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 1000);
// }
