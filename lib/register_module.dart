import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

@registerModule
abstract class RegisterModule {
  @prod
  @lazySingleton
  Connectivity get connectivity;

  @prod
  @lazySingleton
  Client get httpClient => Client();

  @prod
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @prod
  Firestore get firestore => Firestore.instance;

  @prod
  Box<String> get githubBox => Hive.box<String>('prefs');
}

@test
@RegisterAs(Connectivity)
@injectable
class MockDataConnectionChecker extends Mock implements Connectivity {}

@test
@RegisterAs(Client)
@injectable
class MockHttpClient extends Mock implements Client {}

@test
@RegisterAs(Box)
@injectable
class MockBox extends Mock implements Box<String> {}
