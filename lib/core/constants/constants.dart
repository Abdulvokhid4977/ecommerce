import 'package:flutter/cupertino.dart';

sealed class Constants {
  Constants._();
  static GlobalKey<FormState> bottomNavigatorKey = GlobalKey<FormState>();
}

sealed class Colours {
  Colours._();

  static Color blueCustom = const Color.fromRGBO(0, 116, 235, 1);
  static Color greyCustom = const Color.fromRGBO(151, 156, 158, 1);
  static Color backgroundGrey= const Color.fromRGBO(246, 246, 246, 1);
  static Color greyIcon = const Color.fromRGBO(156, 156, 156, 1);
  static Color yellowCustom = const Color.fromRGBO(250, 188, 19, 1);
  static Color yellowCustom2 = const Color.fromRGBO(255, 221, 42, 1);

  static Color priorityBlue = const Color.fromRGBO(0, 159, 238, 1);
  static Color priorityRed = const Color.fromRGBO(238, 43, 0, 1);

  static Color weekDayColor = const Color.fromRGBO(150, 150, 150, 1);
  static Color textFieldColor= const Color.fromRGBO(243, 244, 246, 1);
  static Color elevatedButtonColor= const Color.fromRGBO(254, 232, 233, 1);

}

