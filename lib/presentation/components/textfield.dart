import 'package:e_commerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget textField(
  Function function,
  FocusNode focus1,
  TextEditingController textEditingController,
  String hintText, {
  bool isSearch = false,
}) {
  return TextField(
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colours.greyIcon),
      border: InputBorder.none,
      filled: true,
      fillColor: Colours.backgroundGrey,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 0,
          color: Color.fromRGBO(243, 243, 243, 1),
        ),
      ),
      prefixIcon: isSearch
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10,),
            child: SvgPicture.asset(
                'assets/icons/search.svg',
                colorFilter: ColorFilter.mode(
                  Colours.greyIcon,
                  BlendMode.srcIn,
                ),
              ),
          )
          : null,
    ),
    style: const TextStyle(
      color: Colors.black,
    ),
    controller: textEditingController,
    keyboardType: TextInputType.text,
    onSubmitted: (s) {
      function;
      focus1.unfocus();
    },
  );
}
