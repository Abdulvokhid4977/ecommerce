import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/presentation/bloc/connection/internet_connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Disconnected extends StatelessWidget {
  const Disconnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset('assets/lottie/no_connection.json')),
          SizedBox(
              width: SizeConfig.screenWidth! * 0.5,
              child: Text(
                'No Connection. Please check your internet connection and try again',
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                softWrap: true,
              )),
          TextButton(
              onPressed: () {
                context.read<InternetConnectionBloc>().add(ConnectivityEvent());
              },
              child: Text(
                'Try again',
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
