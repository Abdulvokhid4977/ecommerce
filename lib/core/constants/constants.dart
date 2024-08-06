import 'package:flutter/cupertino.dart';

sealed class Constants {
  Constants._();
}

sealed class Colours {
  Colours._();

  static Color blueCustom = const Color.fromRGBO(0, 116, 235, 1);
  static Color lightGrey = const Color.fromRGBO(239, 239, 239, 1);
  static Color priorityBlue = const Color.fromRGBO(0, 159, 238, 1);
  static Color priorityRed = const Color.fromRGBO(238, 43, 0, 1);
  static Color priorityOrange = const Color.fromRGBO(238, 143, 0, 1);
  static Color weekDayColor = const Color.fromRGBO(150, 150, 150, 1);
  static Color textFieldColor= const Color.fromRGBO(243, 244, 246, 1);
  static Color elevatedButtonColor= const Color.fromRGBO(254, 232, 233, 1);

}

