import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/presentation/components/empty_widget.dart';
import 'package:e_commerce/presentation/components/gridtiles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final bool _isFavoritesEmpty = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Мои желания',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black),
        ),
      ),
      body: _isFavoritesEmpty
          ? const EmptyWidget(
              'assets/images/emoji.png',
              'Ваш список пуст',
              'В вашем списке желаний нет элементов перейдите на главную и выберите',
            )
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      mainAxisExtent: height * 0.46,
                    ),
                    itemBuilder: (ctx, i) {
                      return const GridTileHome();
                    }),
              ),
            ),
    );
  }
}
