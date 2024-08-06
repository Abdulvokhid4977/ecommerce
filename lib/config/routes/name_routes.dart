part of 'app_routes.dart';
sealed class Routes {
  Routes._();
  static const String initial = '/';
  static const String main = '/main';

  static const String details='/details';
  static const String orders='/orders';
  static const String selectLang='/select_lang';
  static const String profile='/profile';
  static const String shopping = '/shopping';
  static const String internetConnection = '/internet_connection';
  static const String settings = '/settings';
  static const String auth = '/auth';
  static const String confirmCode = '/confirm_code';
  static const String register = '/register';
}