import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get result;
}

@RegisterAs(NetworkInfo)
@prod
@lazySingleton
@injectable
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
