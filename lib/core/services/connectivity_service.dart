import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final InternetConnection _connectionChecker =
  InternetConnection();
  final StreamController<bool> _connectionStreamController =
  StreamController<bool>.broadcast();

  ConnectivityService() {
    _checkInitialConnection();
    _connectionChecker.onStatusChange.listen((status) {
      final hasConnection = status == InternetStatus.connected;
      _connectionStreamController.add(hasConnection);
    });
  }

  Stream<bool> get connectionStream => _connectionStreamController.stream;

  Future<void> _checkInitialConnection() async {
    final hasConnection = await _connectionChecker.hasInternetAccess;
    _connectionStreamController.add(hasConnection);
  }

  void dispose() {
    _connectionStreamController.close();
  }
}
