import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'injection_container.iconfig.dart';

final sl = GetIt.instance;

const prod = const Environment('prod');
const test = const Environment('test');

@injectableInit
void init() => $initGetIt(sl);

@registerModule
abstract class RegisterModule {
  @lazySingleton
  Connectivity get prefs;

  @lazySingleton
  http.Client get httpClient => http.Client();

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  Firestore get firestore => Firestore.instance;
}
