import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/presentation/bloc/location/location_bloc.dart';
import 'package:e_commerce/presentation/pages/main_page.dart';
import 'package:e_commerce/presentation/pages/onboarding_page/onboarding_page.dart';
import 'package:e_commerce/presentation/pages/splash/bloc/splash_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _uAnimation;
  late Animation<Offset> _commerceAnimation;
  late Animation<double> _shakeAnimation;
  String? customerId;
  bool? isFirst;

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isFirstTime = prefs.getBool('first') ?? false;
    if (kDebugMode) {
      print('this is a condition of isFirstTime state $isFirstTime');
    }
    setState(() {
      isFirst=isFirstTime;
    });
  }

  void getCustomer() async{
    final customer= await getCustomerId();
    setState(() {
      customerId=customer;
    });
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    getLocation();
    getCustomer();
    _checkFirstTime();
    context.read<LocationBloc>().add(FetchLocationsEvent());

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Define animations for "U" and "commerce"
    _uAnimation = Tween<Offset>(
      begin: const Offset(0, -200),
      end: Offset.zero, // Ends at center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    _commerceAnimation = Tween<Offset>(
      begin: const Offset(0, 200), // "commerce" starts from below
      end: Offset.zero, // Ends at center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    // Define the shake animation for both "U" and "commerce"
    _shakeAnimation = Tween<double>(begin: 0, end: 5 * math.pi)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
    ));

    // Start the animation
    _controller.forward();
  }



  @override
  void didChangeDependencies() {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const SplashEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (_, state) {
          if (state.isTimerFinished && state.selectLanguage && isFirst!=null) {
            if (isFirst!) {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => const OnboardingPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            } else if(customerId!= null && customerId!.isNotEmpty && !isFirst!){
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => const MainPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            } else{

              Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => const OnboardingPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            }


          }
        },
        child: Scaffold(
          body: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: _uAnimation.value, // U moves first
                      child: Transform.rotate(
                        angle: 0.03 * math.sin(_shakeAnimation.value),
                        child: Text(
                          "U",
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colours.blueCustom,
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: _commerceAnimation.value, // commerce moves first
                      child: Transform.rotate(
                        angle: 0.03 * math.sin(_shakeAnimation.value),
                        child: Text(
                          "commerce",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: Colours.greenIndicator,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
