import 'dart:io';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chuck_interceptor/chuck.dart';


import 'config/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (_) => MainBloc(),
        ),
        BlocProvider<SearchBloc>(create: (_)=>SearchBloc())
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
  late Chuck _chuck;

  @override
  void initState() {
    super.initState();
    _chuck = Chuck(
      showNotification: true,
      showInspectorOnShake: true,
      darkTheme: false,
      maxCallsCount: 1000,
    );
  }

  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colours.backgroundGrey,
      systemNavigationBarIconBrightness: Brightness.dark,

    ));
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData(
        scaffoldBackgroundColor: Colours.backgroundGrey,
        appBarTheme: AppBarTheme(color: Colours.backgroundGrey),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: false,
      ),
      navigatorKey: rootNavigatorKey,
      onUnknownRoute: AppRoutes.onUnknownRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: Routes.register,
      debugShowCheckedModeBanner: false,
    );
  }
}
