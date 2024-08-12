import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the status bar color
      statusBarIconBrightness: Brightness.dark, // For light text/icons on the status bar
    ));
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: false,
      ),
      navigatorKey: rootNavigatorKey,
      onUnknownRoute: AppRoutes.onUnknownRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: Routes.details,
      debugShowCheckedModeBanner: false,
    );
  }
}
