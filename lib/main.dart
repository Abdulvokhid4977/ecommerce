import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/location_model.dart';
import 'package:e_commerce/presentation/bloc/connection/internet_connection_bloc.dart';
import 'package:e_commerce/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:e_commerce/presentation/bloc/location/location_bloc.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/pages/auth/bloc/opt/otp_bloc.dart';
import 'package:e_commerce/presentation/pages/auth/bloc/register/register_bloc.dart';
import 'package:e_commerce/presentation/pages/auth/pages/confirm_code.dart';
import 'package:e_commerce/presentation/pages/auth/pages/register_page.dart';
import 'package:e_commerce/presentation/pages/order/bloc/order_bloc.dart';
import 'package:e_commerce/presentation/pages/search/bloc/search_bloc.dart';
import 'package:e_commerce/presentation/pages/auth/pages/otp_page.dart';

import 'package:e_commerce/presentation/pages/error/pages/disconnected.dart';
import 'package:e_commerce/presentation/pages/main_page.dart';
import 'package:e_commerce/presentation/pages/splash/pages/splash_page.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


import 'config/routes/app_routes.dart';

import 'core/wrappers/cart_item_wrapper.dart';
import 'data/models/product_model.dart';
import 'data/models/register_model.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CartItemWrapperAdapter());
  Hive.registerAdapter(ProductElementAdapter());
  Hive.registerAdapter(ProductColorAdapter());
  Hive.registerAdapter(LocationElementAdapter());
  Hive.registerAdapter(RegisterAdapter());
  await setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (_) => MainBloc()),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
        BlocProvider<FavoriteBloc>(create: (_) => FavoriteBloc()),
        BlocProvider<LocationBloc>(create: (_) => LocationBloc()),
        BlocProvider<InternetConnectionBloc>(create: (_) => InternetConnectionBloc(InternetConnection())),
        BlocProvider<OrderBloc>(create: (_) => OrderBloc()),
        BlocProvider<OtpBloc>(create: (_) => OtpBloc()),
        BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),


      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colours.backgroundGrey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    final theme = ThemeData(
      scaffoldBackgroundColor: Colours.backgroundGrey,
      appBarTheme: AppBarTheme(color: Colours.backgroundGrey),
      textTheme: GoogleFonts.interTextTheme(),
      useMaterial3: false,
    );

    return BlocBuilder<InternetConnectionBloc, InternetConnectionState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'E-commerce',
          theme: theme,
          navigatorKey: rootNavigatorKey,
          onUnknownRoute: AppRoutes.onUnknownRoute,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          home: state is InternetDisconnected
              ? const Disconnected()
              : const SplashPage(),
        );
      },
    );
  }
}
