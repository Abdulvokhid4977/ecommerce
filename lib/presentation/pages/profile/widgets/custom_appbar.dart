import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatefulWidget {
  final List<Register> customer;
  const CustomAppbar(this.customer,{super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {

  bool? isLoggedIn;
  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 13) {
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 6)} '
          '${phoneNumber.substring(6, 9)} ${phoneNumber.substring(9, 11)} '
          '${phoneNumber.substring(11, 13)}';
    } else {
      return phoneNumber;
    }
  }
  void checkUser(){
    if(widget.customer.isNotEmpty){
      setState(() {
        isLoggedIn=true;
      });
    }else{
      setState(() {
        isLoggedIn=false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();

  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colours.blueCustom,
      automaticallyImplyLeading: false,
      expandedHeight: SizeConfig.screenHeight! * 0.3,
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double percentage = (constraints.maxHeight - kToolbarHeight) /
              (SizeConfig.screenHeight! * 0.3 - kToolbarHeight);

          double avatarRadius = 35.0 * percentage.clamp(0.6, 1.0);

          return FlexibleSpaceBar(
            centerTitle: true,
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/images/profile_background.jpg",
                  fit: BoxFit.cover,
                ),
                Positioned(
                  width: SizeConfig.screenWidth,
                  top: SizeConfig.statusBar! + 10,
                  child: Text(
                    "Личный кабинет",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            title: Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const AssetImage(
                    "assets/images/profile.jpg",
                  ),
                ),
                AppUtils.kWidth12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLoggedIn! ? '${widget.customer[0].name} ${widget.customer[0].surname[0]}. ' : 'Неизвестный',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        isLoggedIn! ? formatPhoneNumber(widget.customer[0].phoneNumber): 'Неизвестный',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
