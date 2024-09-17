part of 'internet_connection_bloc.dart';

@immutable
abstract class InternetConnectionState {}

class InternetInitial extends InternetConnectionState{}

class InternetConnected extends InternetConnectionState {}

class InternetDisconnected extends InternetConnectionState{}
