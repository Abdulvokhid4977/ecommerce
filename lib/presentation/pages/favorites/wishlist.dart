import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:e_commerce/presentation/components/gridtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../bloc/main/main_bloc.dart' as main;

class Wishlist extends StatelessWidget {
  final Product state;
  const Wishlist(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<main.MainBloc>().add(main.FetchDataEvent(false));
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colours.blueCustom,
            )),
        backgroundColor: Colours.backgroundGrey,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
        title: Text(
          'Мои желания',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Colors.black),
        ),
      ),
      body: state.product.isEmpty
          ? const EmptyWidget(
        'assets/images/emoji.png',
        'Ваш список пуст',
        'В вашем списке желаний нет элементов перейдите на главную и выберите',
      )
          : SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 16),
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.product.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                mainAxisExtent: SizeConfig.screenHeight! * 0.46,
              ),
              itemBuilder: (ctx, i) {
                return GridTileProduct(
                  state.product[i].favorite,
                  state.product[i],);
              }),
        ),
      ),
    );
  }
}
