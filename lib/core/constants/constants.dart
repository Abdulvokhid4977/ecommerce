import 'package:e_commerce/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

sealed class Constants {
  Constants._();
  static Product products=Product(count: 0, product: []);
  static FocusNode focus=FocusNode();
  static const yandexMapKey= '129df637-72e2-4d7b-82a6-54dd1be08fae';
  static const baseUrl='https://ulab-project-1-e3lm.onrender.com/e_commerce/api/v1';
}
class SizeConfig {
  static double? screenHeight;
  static double? screenWidth;
  static double? statusBar;

  void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth=MediaQuery.of(context).size.width;
    statusBar=MediaQuery.of(context).viewPadding.top;

  }
}

sealed class Colours {
  Colours._();

  static Color blueCustom = const Color.fromRGBO(0, 116, 235, 1);
  static Color textFieldBlue = const Color.fromRGBO(0, 116, 235, 0.05);
  static Color greyCustom = const Color.fromRGBO(151, 156, 158, 1);
  static Color backgroundGrey= const Color.fromRGBO(246, 246, 246, 1);
  static Color textFieldGrey= const Color.fromRGBO(233, 233, 233, 1);
  static Color greyIcon = const Color.fromRGBO(156, 156, 156, 1);
  static Color yellowCustom = const Color.fromRGBO(250, 188, 19, 1);
  static Color yellowCustom2 = const Color.fromRGBO(255, 221, 42, 1);
  static Color redCustom = const Color.fromRGBO(235, 42, 0, 1);
  static Color greenCustom = const Color.fromRGBO(192, 232, 178, 1);
  static Color yellowCustom3= const Color.fromRGBO(246, 230, 199, 1);
  static Color greenIndicator = const Color.fromRGBO(48, 158, 58, 1);


}

