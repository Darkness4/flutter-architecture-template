import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get result;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<ConnectivityResult> get result =>
      connectionChecker.checkConnectivity();
}
