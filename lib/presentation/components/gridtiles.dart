import 'package:e_commerce/config/routes/app_routes.dart';
import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GridTileHome extends StatefulWidget {
  const GridTileHome({super.key});

  @override
  State<GridTileHome> createState() => _GridTileHomeState();
}

class _GridTileHomeState extends State<GridTileHome> {
  bool _isFavorite=false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){Navigator.of(context).pushNamed(Routes.details);},
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/s22.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              AppUtils.kHeight10,
              Text(
                'Samsung S22 Ultra 12/256gb Black',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                softWrap: true,
              ),
              AppUtils.kHeight10,
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colours.yellowCustom,
                  ),
                  Text(
                    '5.0 (80 заказов)',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colours.greyIcon,
                    ),
                  ),
                ],
              ),
              AppUtils.kHeight10,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                width: width * 0.33,
                decoration: BoxDecoration(
                  color: Colours.yellowCustom2,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '109 378 сум/мес',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppUtils.kHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '1 400 000 сум',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colours.greyIcon,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '899 000 сум',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){},
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colours.greyIcon, width: 1),
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          'assets/icons/cart.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 1,
            right: 1,
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  _isFavorite=!_isFavorite;
                });
              },
              icon:  Icon(
                Icons.favorite,
                color: _isFavorite ? Colors.red: Colours.greyIcon,
              ),
            ),
          ),
          Positioned(
            top: height * 0.187,
            left: 4,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colours.blueCustom,
                ),
                child: Text(
                  'Распродажа',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),),
          ),
        ],
      ),
    );
  }
}
