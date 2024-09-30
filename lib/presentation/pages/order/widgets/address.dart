import 'package:e_commerce/data/models/register_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../profile/pages/map_page.dart';

class Address extends StatefulWidget {
  final bool isDelivery;
  final LocationWithDetails locationDetails;
  const Address(this.isDelivery, this.locationDetails,{super.key});

  @override
  State<Address> createState() => _AddressState();
}

Widget textFormField(String text1, String text2) {
  return Container(
    padding: const EdgeInsets.only(left: 16),
    height: SizeConfig.screenHeight! * 0.07,
    width: SizeConfig.screenWidth,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      color: Colours.textFieldGrey,
    ),
    child: TextFormField(
      enabled: false,
      initialValue: text2,
      cursorColor: Colours.greyIcon,
      decoration: InputDecoration(
          border: InputBorder.none,
          label: Text(text1),
          labelStyle: TextStyle(color: Colours.greyIcon)),
    ),
  );
}

Widget customRow(String text,
    {Icon icon = const Icon(Icons.location_on_outlined), bool hasIcon = true}) {
  return Row(
    children: [
      hasIcon
          ? icon
          : const SizedBox(
              width: 24,
            ),
      AppUtils.kWidth16,
      SizedBox(
        width: SizeConfig.screenWidth! * 0.7,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
          softWrap: true,
        ),
      ),
    ],
  );
}

Widget checked(bool isChecked, String text) {
  return Row(
    children: [
      Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: isChecked ? Colours.blueCustom : Colors.black, width: 2),
        ),
        child: Center(
          child: Container(
            width: 13,
            height: 13,
            decoration: isChecked
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colours.blueCustom,
                  )
                : null,
          ),
        ),
      ),
      AppUtils.kWidth16,
      Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget customText(String text1) {
  return Text(
    text1,
    style: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  );
}

class _AddressState extends State<Address> {
  Point? chosenPoint;
  @override
  void initState() {
    super.initState();
  }

  Widget elevatedButton(String text, Color color1, Color color2, bool isDone,
      bool isChange, BuildContext context,
      {bool isDelivery = false}) {
    return ElevatedButton(
      onPressed: () async {
        if (isChange) {
          if (isDelivery) {
            print('open map with your current location');
          } else {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapPage(
                  showModalOnTap: true,
                  onMarkerChosen: (point,s1,s2,s3,s4) {
                    print("$point, $s1, $s2, $s3, $s4");
                    setState(() {
                      chosenPoint=Point( latitude: point.latitude, longitude: point.longitude,);
                      widget.locationDetails.address = s1;
                      widget.locationDetails.name =s2;
                      widget.locationDetails.opensAt = s3;
                      widget.locationDetails.closesAt = s4;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          }
        }
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: color1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize:
            Size(SizeConfig.screenWidth!, SizeConfig.screenHeight! * 0.06),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: color2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText('Адрес доставки'),
        AppUtils.kHeight16,
        customRow(
          widget.isDelivery ? 'Current Location' : widget.locationDetails.name,
          icon: const Icon(Icons.location_on_outlined),
        ),
        AppUtils.kHeight10,
        customRow(
            widget.isDelivery ? "address" : widget.locationDetails.address,
            hasIcon: false),
        AppUtils.kHeight10,
        customRow(
            '${widget.locationDetails.opensAt}-${widget.locationDetails.closesAt} без выходных',
            hasIcon: false),
        AppUtils.kHeight16,
        elevatedButton('Изменить', Colours.textFieldGrey, Colors.black, false, true, context, isDelivery: widget.isDelivery ? true : false),
      ],
    );
  }
}
