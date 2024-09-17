import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_connection_event.dart';
part 'internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  final InternetConnection _internetConnectionChecker;
  late StreamSubscription<InternetStatus> _subscription;

  InternetConnectionBloc(this._internetConnectionChecker)
      : super(InternetInitial()) {
    _subscription = _internetConnectionChecker.onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        print('I am here');
        add(ConnectivityEvent()); // Trigger event to check connectivity
      } else {
        print('I am disconnected');
        add(ConnectivityEvent()); // Trigger event to handle no connection
      }
    });
    on<ConnectivityEvent>((event, emit) async {
      emit(InternetInitial());
      bool isConnected = await _internetConnectionChecker.hasInternetAccess;
      print(isConnected);
      if (isConnected) {
        emit(InternetConnected());
      } else {
        emit(InternetDisconnected());
      }
    });
  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
