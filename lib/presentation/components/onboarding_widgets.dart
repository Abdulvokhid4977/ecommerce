import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingWidgets extends StatelessWidget {
  final int index;
  final String first;
  final String second;

  const OnboardingWidgets(this.index, this.first, this.second, {super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 432,
          child: Center(
            child: Image.asset(
              'assets/images/onboarding$index.png',
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  first,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Text(
                second,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
