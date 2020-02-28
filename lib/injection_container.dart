import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'injection_container.iconfig.dart';

final sl = GetIt.instance;

@injectableInit
void init({String env = Environment.prod}) => $initGetIt(sl, environment: env);

@registerModule
abstract class RegisterModule {
  @prod
  @lazySingleton
  Connectivity get connectivity;

  @prod
  @lazySingleton
  http.Client get httpClient => http.Client();

  @prod
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  @prod
  Firestore get firestore => Firestore.instance;
}

@test
@RegisterAs(Connectivity)
@injectable
class MockDataConnectionChecker extends Mock implements Connectivity {}

@test
@RegisterAs(http.Client)
@injectable
class MockHttpClient extends Mock implements http.Client {}
