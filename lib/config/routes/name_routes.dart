part of 'app_routes.dart';
sealed class Routes {
  Routes._();
  static const String initial = '/';
  static const String main = '/main';
  static const String auth = '/auth';
  static const String favorites='/favorites';
  static const String search = '/search';
  static const String order='/orders';
  static const String details='/details';
  static const String profile='/profile';
  static const String cart = '/cart';
  static const String givingOrder = '/givingorder';



  static const String register = '/register';
}