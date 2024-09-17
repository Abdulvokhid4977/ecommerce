import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/constants.dart';
import '../../../data/models/product_model.dart';
import '../../components/gridtile.dart';

class GridViewWidget extends StatelessWidget {
  final Product product;

  const GridViewWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    if (product.product.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: product.product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              mainAxisExtent: SizeConfig.screenHeight! * 0.4,
            ),
            itemBuilder: (ctx, i) {
              return GridTileProduct(
                product.product[i].favorite,
                product.product[i],
              );
            }),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Lottie.asset('assets/lottie/empty.json'),
            AppUtils.kHeight10,
            Text(
              'Не могли найти ваш товар',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            AppUtils.kHeight10,
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12,),
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
      );
    }
  }
}
