part of 'app_routes.dart';
sealed class Routes {
  Routes._();
  static const String initial = '/';
  static const String main = '/main';
  static const String favorites='/favorites';
  static const String search = '/search';

  static const String details='/details';
  static const String orders='/orders';
  static const String profile='/profile';
  static const String shopping = '/shopping';
  static const String settings = '/settings';
  static const String auth = '/auth';
  static const String confirmCode = '/confirm_code';
  static const String register = '/register';
}