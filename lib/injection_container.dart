import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/firebase_auth_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/github/asset_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/release_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/repositories/firebase_auth/app_user_repository_impl.dart';
import 'package:flutter_architecture_template/data/repositories/github/releases_repository_impl.dart';
import 'package:flutter_architecture_template/data/repositories/github/user_repository_impl.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';
import 'package:flutter_architecture_template/domain/repositories/github/releases_repository.dart';
import 'package:flutter_architecture_template/domain/repositories/github/user_repository.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_auth_state.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_user.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signin.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signout.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signup.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_releases.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_user.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/authentication/authentication_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/login/bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/register/bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/main_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'data/mappers/firebase_auth/app_user_mapper.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final Firestore firestore = Firestore.instance;
final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => MainPageBloc(),
  );
  sl.registerFactory(
    () => GithubReleasesBloc(
      getGithubReleases: sl<GetGithubReleases>(),
    ),
  );
  sl.registerFactory(
    () => GithubUserBloc(
      getGithubUser: sl<GetGithubUser>(),
    ),
  );
  sl.registerFactory(
    () => LoginBloc(
      firebaseAuthSignIn: sl<FirebaseAuthSignIn>(),
    ),
  );
  sl.registerFactory(
    () => AuthenticationBloc(
      firebaseAuthSignOut: sl<FirebaseAuthSignOut>(),
      getAppUser: sl<GetAppUser>(),
      getAuthState: sl<GetAuthState>(),
    ),
  );
  sl.registerFactory(
    () => RegisterBloc(
      firebaseAuthSignUp: sl<FirebaseAuthSignUp>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetGithubUser(sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetGithubReleases(sl<ReleasesRepository>()),
  );
  sl.registerLazySingleton(
    () => GetAuthState(sl<AppUserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetAppUser(sl<AppUserRepository>()),
  );
  sl.registerLazySingleton(
    () => FirebaseAuthSignIn(sl<AppUserRepository>()),
  );
  sl.registerLazySingleton(
    () => FirebaseAuthSignOut(sl<AppUserRepository>()),
  );
  sl.registerLazySingleton(
    () => FirebaseAuthSignUp(sl<AppUserRepository>()),
  );

  // Repository
  sl.registerLazySingleton<ReleasesRepository>(
    () => ReleasesRepositoryImpl(
      localDataSource: sl<GithubLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      remoteDataSource: sl<GithubRemoteDataSource>(),
      releaseMapper: sl<GithubReleaseMapper>(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<GithubRemoteDataSource>(),
      userMapper: sl<GithubUserMapper>(),
    ),
  );
  sl.registerLazySingleton<AppUserRepository>(
    () => AppUserRepositoryImpl(
      dataSource: sl<FirebaseAuthDataSource>(),
      userMapper: sl<AppUserMapper>(),
    ),
  );

  // Mappers
  sl.registerLazySingleton<GithubAssetMapper>(
    () => GithubAssetMapper(userMapper: sl<GithubUserMapper>()),
  );
  sl.registerLazySingleton<GithubUserMapper>(
    () => const GithubUserMapper(),
  );
  sl.registerLazySingleton<GithubReleaseMapper>(
    () => GithubReleaseMapper(
      userMapper: sl<GithubUserMapper>(),
      assetMapper: sl<GithubAssetMapper>(),
    ),
  );
  sl.registerLazySingleton<AppUserMapper>(
    () => const AppUserMapper(),
  );

  // Data sources
  sl.registerLazySingleton<GithubRemoteDataSource>(
    () => GithubRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  sl.registerLazySingleton<GithubLocalDataSource>(
    () => GithubLocalDataSourceImpl(box: sl.get<Box<dynamic>>()),
  );

  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(
      auth: firebaseAuth,
      db: firestore,
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  //! External
  if (!kIsWeb) {
    final appDocumentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
  }
  await Hive.openBox<dynamic>('prefs');
  sl.registerLazySingleton<Box<dynamic>>(() => Hive.box<dynamic>('prefs'));
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
}
