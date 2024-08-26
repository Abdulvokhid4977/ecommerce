import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget extends StatelessWidget {
  final String assetPath;
  final String text1;
  final String text2;

  const EmptyWidget(this.assetPath, this.text1, this.text2, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      bloc: context.read<MainBloc>(),
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(assetPath),
                AppUtils.kHeight32,
                Text(
                  text1,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                AppUtils.kHeight10,
                Text(
                  text2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colours.greyIcon,
                  ),
                ),
                AppUtils.kHeight16,
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colours.blueCustom,
                    ),
                    child: Text(
                      'Go to Home Page',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<MainBloc>().add(FetchDataEvent(false));
                    Navigator.of(context).pushNamed(Routes.main);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
