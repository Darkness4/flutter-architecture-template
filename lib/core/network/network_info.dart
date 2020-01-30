import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get result;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<ConnectivityResult> get result {
    if (kIsWeb) {
      return Future.value(ConnectivityResult.wifi);
    } else {
      return connectionChecker.checkConnectivity();
    }
  }
}
