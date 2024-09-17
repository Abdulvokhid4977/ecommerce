import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/bloc/connection/internet_connection_bloc.dart';
import 'package:e_commerce/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:e_commerce/presentation/pages/error/pages/disconnected.dart';
import 'package:e_commerce/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';

import 'config/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (_) => MainBloc()),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
        BlocProvider<FavoriteBloc>(create: (_) => FavoriteBloc()),
        BlocProvider<InternetConnectionBloc>(create: (_) => InternetConnectionBloc(InternetConnection()),
        ),
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

    return MaterialApp(
      title: 'E-commerce',
      theme: theme,
      navigatorKey: rootNavigatorKey,
      onUnknownRoute: AppRoutes.onUnknownRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<InternetConnectionBloc, InternetConnectionState>(
        builder: (context, state) {
          if (state is InternetInitial) {
            return Scaffold(
              body: Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 140, width: 140),
              ),
            );
          } else if (state is InternetConnected) {
            return const MainPage();
          } else {
            return const Disconnected();
          }
        },
      ),
    );
  }
}
